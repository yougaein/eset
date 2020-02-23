/*
 * Copyright (c) 2020
 *
 * Yougaein@github (Kokeji Yougain)
 */

#include "set_tz"
#include "map_tz"
#include <algorithm>
#include <ruby.h>
#include <new>


using namespace std;
using namespace tz;


static ID ID_CALL;
static ID ID_LESS;
static ID ID_EQ;
static VALUE rb_mYk;

#include <iostream>

struct ValueCompareBy{
	VALUE block;
	ValueCompareBy(VALUE b) : block(b){ }
	bool operator()(VALUE a, VALUE b){
		if(block != Qnil){
			VALUE ac = rb_funcall(block, ID_CALL, 1, a);
			VALUE bc = rb_funcall(block, ID_CALL, 1, b);
			VALUE res = rb_funcall(ac, ID_LESS, 1, bc);
			return res != Qfalse && res != Qnil;
		}else{
			return a < b;
		}
	}
};


typedef multiset<VALUE, ValueCompareBy> EMTSet;
typedef set<VALUE, ValueCompareBy> ESet;
typedef multimap<VALUE, VALUE, ValueCompareBy> EMTMap; 
typedef map<VALUE, VALUE, ValueCompareBy> EMap; 


template <typename EMSet>
struct ESetWrap{
	typedef EMSet Target;
	static VALUE cESet;
	static VALUE cESetIt;

	typedef typename EMSet::iterator iterator;

	inline static iterator getIterator(pair<iterator, bool> r){
		return r.first;
	}


	inline static iterator getIterator(iterator r){
		return r;
	}


	static void eMSet_free(EMSet* p){
		p->~EMSet();
		ruby_xfree(p);
	}


	static void eMSet_rb_gc_mark(std::pair<VALUE, VALUE> arg){
		rb_gc_mark(arg.first);
		rb_gc_mark(arg.second);
	}

	static void eMSet_rb_gc_mark(VALUE arg){
		rb_gc_mark(arg);
	}

	static void eMSet_mark(EMSet* p){
		for(iterator it = p->begin() ; it != p->end() ; ++it)
			eMSet_rb_gc_mark(*it);
		rb_gc_mark(p->_M_t._M_impl._M_key_compare.block);
	}

	static void eMSetIt_free(iterator* p){
		p->iterator::~iterator();
		ruby_xfree(p);
	}


	static void eMSetIt_mark(iterator* p){
		if((*p)._M_node){
			EMSet* q = ((EMSet*)p->_M_node->_TZ_tree);
			if(q && q->end() != *p){
				eMSet_rb_gc_mark(**p);
			}
			VALUE m = q->_M_t.memo;
			if(m){
				rb_gc_mark(m);
			}
		}
	}

	// EMSet.new do |a, b|
	//   a < b
	// end

	static EMSet* eMSet(VALUE self){
		EMSet* p;
		Data_Get_Struct(self, EMSet, p);
		return p;
	}


	static iterator* eMSetIt(VALUE self){
		iterator* p;
		Data_Get_Struct(self, iterator, p);
		return p;
	}


	static VALUE eMSet_alloc(VALUE klass){
		void* p = ruby_xmalloc(sizeof(EMSet));
		new(p) EMSet(ValueCompareBy(Qnil));
		return Data_Wrap_Struct(klass, eMSet_mark, eMSet_free, p);
	}


	static VALUE eMSetIt_alloc(VALUE klass){
		void* p = ruby_xmalloc(sizeof(iterator));
		new(p) iterator();
		return Data_Wrap_Struct(klass, eMSetIt_mark, eMSetIt_free, p);
	}


	static VALUE eMSet_init(int argc, VALUE *argv, VALUE self) {
		EMSet* p = eMSet(self);
		VALUE block;
		rb_scan_args(argc, argv, "0&", &block);
		p->~EMSet();
		new(p) EMSet(ValueCompareBy(block));
		p->_M_t.memo = self;
		return Qnil;
	}


	static VALUE eMSetIt_assign(VALUE self, VALUE arg) {
		iterator* a = eMSetIt(self);
		if(!rb_obj_is_instance_of(arg, cESetIt)){
			rb_raise(rb_eArgError, "Right operand is not compatible type");
			return Qnil;
		}
		iterator* b = eMSetIt(arg);
		*a = *b;
		return self;
	}


	static VALUE eMSetIt_eq(VALUE self, VALUE arg) {
		iterator* a = eMSetIt(self);
		if(!rb_obj_is_instance_of(arg, cESetIt)){
			rb_raise(rb_eArgError, "Right operand is not compatible type");
			return Qnil;
		}
		iterator* b = eMSetIt(arg);
		return *a == *b ? Qtrue : Qfalse;
	}


	static VALUE eMSetIt_neq(VALUE self, VALUE arg) {
		iterator* a = eMSetIt(self);
		if(!rb_obj_is_instance_of(arg, cESetIt)){
			rb_raise(rb_eArgError, "Right operand is not compatible type");
			return Qnil;
		}
		iterator* b = eMSetIt(arg);
		return *a != *b ? Qtrue : Qfalse;
	}


	static VALUE eMSet_upper_bound(VALUE self, VALUE arg) {
		EMSet* p = eMSet(self);
		VALUE itv = eMSetIt_alloc(cESetIt);
		iterator* it = eMSetIt(itv);
		new(it) iterator();
		*it = p->upper_bound(arg);
		return itv;
	}


	static VALUE eMSet_lower_bound(VALUE self, VALUE arg) {
		EMSet* p = eMSet(self);
		VALUE itv = eMSetIt_alloc(cESetIt);
		iterator* it = eMSetIt(itv);
		new(it) iterator();
		*it = p->lower_bound(arg);
		return itv;
	}


	static VALUE eMSet_begin(VALUE self) {
		EMSet* p = eMSet(self);
		VALUE itv = eMSetIt_alloc(cESetIt);
		iterator* it = eMSetIt(itv);
		new(it) iterator();
		*it = p->begin();
		return itv;
	}


	static VALUE eMSet_size(VALUE self) {
		EMSet* p = eMSet(self);
		return INT2FIX(p->size());
	}


	static VALUE eMSet_end(VALUE self) {
		EMSet* p = eMSet(self);
		VALUE itv = eMSetIt_alloc(cESetIt);
		iterator* it = eMSetIt(itv);
		new(it) iterator();
		*it = p->end();
		return itv;
	}

	inline static VALUE toValue(iterator dummy, VALUE itv){
		return itv;
	}


	inline static VALUE toValue(pair<iterator, bool> r, VALUE itv){
		VALUE elts[2] = {itv, r.second ? Qtrue : Qfalse};
		return rb_ary_new_from_values(2, (const VALUE*)&elts);
	}

	inline static VALUE toValue(pair<VALUE, VALUE> r){
		VALUE elts[2] = {r.first, r.second};
		return rb_ary_new_from_values(2, (const VALUE*)&elts);
	}

	inline static VALUE toValue(VALUE r){
		return r;
	}


	inline static VALUE getFirst(pair<VALUE, VALUE> r){
		return r.first;
	}

	inline static VALUE getFirst(VALUE r){
		return r;
	}


	template <class T>
	inline static VALUE insertRet(T r){
		VALUE itv = eMSetIt_alloc(cESetIt);
		iterator* it = eMSetIt(itv);
		new(it) iterator(getIterator(r));
		return toValue(r, itv);
	}


	inline static VALUE addRet(pair<iterator, bool> r){
		return r.second ? Qtrue : Qfalse;
	}

	inline static VALUE addRet(iterator){
		return Qtrue;
	}


	static VALUE eMSet_each(VALUE self) {
		EMSet* p = eMSet(self);
		VALUE ret = Qnil;
		for(typename EMSet::iterator it = p->begin() ; it != p->end() ; ++it)
			ret = rb_yield(toValue(*it));
		return ret;
	}


	static VALUE eMSetIt_clone(VALUE self) {
		iterator* it = eMSetIt(self);
		VALUE itv = eMSetIt_alloc(cESetIt);
		iterator* rt = eMSetIt(itv);
		new(rt) iterator(*it);
		return itv;
	}


	static VALUE eMSetIt_inc(VALUE self) {
		iterator* it = eMSetIt(self);
		if(it->_M_node->_TZ_destroyer){
			rb_raise(rb_eArgError, "the element is already erased");
			return Qnil;
		}
		if(*it == ((EMSet*)it->_M_node->_TZ_tree)->end()){
			rb_raise(rb_eRangeError, "advancing over the end");
			return Qnil;
		}
		++*it;
		return self;
	}


	static VALUE eMSetIt_dec(VALUE self) {
		iterator* it = eMSetIt(self);
		if(it->_M_node->_TZ_destroyer){
			rb_raise(rb_eArgError, "the element is already erased");
			return Qnil;
		}
		if(*it == ((EMSet*)it->_M_node->_TZ_tree)->begin()){
			rb_raise(rb_eRangeError, "rewinding over the begining");
			return Qnil;
		}
		--*it;
		return self;
	}

	static VALUE eMSetIt_isEnd(VALUE self) {
		iterator* it = eMSetIt(self);
		if(it->_M_node->_TZ_destroyer){
			rb_raise(rb_eArgError, "the element is already erased");
			return Qnil;
		}
		if(*it == ((EMSet*)it->_M_node->_TZ_tree)->end()){
			return Qtrue;
		}else{
			return Qfalse;
		}
	}


	static VALUE eMSetIt_isErased(VALUE self) {
		iterator* it = eMSetIt(self);
		if(it->_M_node->_TZ_destroyer){
			return Qtrue;
		}else{
			return Qfalse;
		}
	}

	static VALUE eMSetIt_succ(VALUE self){
		VALUE ret = eMSetIt_clone(self);
		eMSetIt_inc(ret);
		return ret;
	}

	static VALUE eMSetIt_spaceshipOp(VALUE self, VALUE other){
		iterator* a = eMSetIt(self);
		iterator* b = eMSetIt(other);
		if(a->_M_node->_TZ_destroyer){
			rb_raise(rb_eArgError, "the left operand is already erased");
			return Qnil;
		}
		if(b->_M_node->_TZ_destroyer){
			rb_raise(rb_eArgError, "the right operand is already erased");
			return Qnil;
		}
		if((EMSet*)a->_M_node->_TZ_tree != (EMSet*)b->_M_node->_TZ_tree){
			rb_raise(rb_eArgError, "the left operand and the right operand are not from the same container");
			return Qnil;
		}
		if(*a == *b)
			return INT2FIX(0);
		if(*a == ((EMSet*)a->_M_node->_TZ_tree)->end()){
			return INT2FIX(1);
		}else{
			if(*b == ((EMSet*)b->_M_node->_TZ_tree)->end()){
				return INT2FIX(-1);
			}else{
				VALUE res = rb_funcall(**a, ID_LESS, 1, **b);
				if(res == Qtrue)
					return INT2FIX(-1);
				else{
					res = rb_funcall(**b, ID_LESS, 1, **a);
					if(res == Qtrue)
						return INT2FIX(1);
					else{
						iterator tmp = *a;
						while(1){
							++tmp;
							if(tmp == ((EMSet*)a->_M_node->_TZ_tree)->end() || rb_funcall(*tmp, ID_LESS, 1, **b) != Qfalse || rb_funcall(*tmp, ID_LESS, 1, **a) != Qfalse)
								break;
							if(tmp == *b)
								return INT2FIX(1);
						}
						tmp = *a;
						while(1){
							--tmp;
							if(rb_funcall(**a, ID_LESS, 1, **b) != Qfalse || rb_funcall(**b, ID_LESS, 1, **a) != Qfalse)
								break;
							if(tmp == *b)
								return INT2FIX(-1);
							if(tmp == ((EMSet*)a->_M_node->_TZ_tree)->begin()){
								rb_raise(rb_eArgError, "Unknown range");
								return Qnil;								
							}
						}
					}
				}
			}
		}
	}

	static VALUE eMSet_find(int argc, VALUE *argv, VALUE self){
		VALUE b, e, v;

		rb_scan_args(argc, argv, "12", &b, &e, &v);
		if(!rb_obj_is_instance_of(b, cESetIt)){
			rb_raise(rb_eArgError, "First argument is not compatible type");
			return Qnil;
		}
		if(!rb_obj_is_instance_of(e, cESetIt)){
			rb_raise(rb_eArgError, "Second argument is not compatible type");
			return Qnil;
		}
		iterator* bg = eMSetIt(b), * ed = eMSetIt(e);
		if(bg->_M_node->_TZ_destroyer){
			rb_raise(rb_eArgError, "First argument is already erased");
			return Qnil;
		}
		if(ed->_M_node->_TZ_destroyer){
			rb_raise(rb_eArgError, "Second argument is already erased");
			return Qnil;
		}
		if((EMSet*)bg->_M_node->_TZ_tree != (EMSet*)ed->_M_node->_TZ_tree){
			rb_raise(rb_eArgError, "First and last iterators are not from the same container");
			return Qnil;
		}
		if(v != Qnil){
			if(!rb_block_given_p()){
				for(iterator it = *bg ; it != *ed ; ++it){
					if(it == ((EMSet*)bg->_M_node->_TZ_tree)->end()){
						rb_raise(rb_eRangeError, "Dereferencing the end iterator");
						return Qnil;
					}
					VALUE res = rb_funcall(getFirst(*it), ID_EQ, 1, v);
					if(res != Qnil && res != Qfalse)
						return toValue(*it);
				}
			}else{
				for(iterator it = *bg ; it != *ed ; ++it){
					if(it == ((EMSet*)bg->_M_node->_TZ_tree)->end()){
						rb_raise(rb_eRangeError, "Dereferencing the end iterator");
						return Qnil;
					}
					VALUE res = rb_funcall(getFirst(*it), ID_EQ, 1, v);
					if(res != Qnil && res != Qfalse){
						res = rb_yield(getFirst(*it));
						if(res != Qnil && res != Qfalse)
							return toValue(*it);
					}
				}
			}
		}else if(rb_block_given_p()){
			for(iterator it = *bg ; it != *ed ; ++it){
				if(it == ((EMSet*)bg->_M_node->_TZ_tree)->end()){
					rb_raise(rb_eRangeError, "Dereferencing the end iterator");
					return Qnil;
				}
				VALUE res = rb_yield(getFirst(*it));
				if(res != Qnil && res != Qfalse)
					return toValue(*it);
			}
		}else{
			rb_raise(rb_eArgError, "Both argument and block are missing");
			return Qnil;
		}
		return e;
	}
	static VALUE eMSet_find1(VALUE self, VALUE v){
		EMSet* p = eMSet(self);
		VALUE itv = eMSetIt_alloc(cESetIt);
		iterator* it = eMSetIt(itv);
		new(it) iterator(p->find(v));
		return itv;
	}


	static VALUE eMSet_for_each(VALUE self, VALUE b, VALUE e) {
		VALUE tov;
		if(!rb_block_given_p()){
			rb_raise(rb_eArgError, "Block missing");
			return Qnil;
		}
		if(!rb_obj_is_instance_of(b, cESetIt)){
			rb_raise(rb_eArgError, "First argument is not compatible type");
			return Qnil;
		}
		if(!rb_obj_is_instance_of(e, cESetIt)){
			rb_raise(rb_eArgError, "Second argument is not compatible type");
			return Qnil;
		}
		iterator* bg = eMSetIt(b), * ed = eMSetIt(e);
		if(bg->_M_node->_TZ_destroyer){
			rb_raise(rb_eArgError, "First argument is already erased");
			return Qnil;
		}
		if(ed->_M_node->_TZ_destroyer){
			rb_raise(rb_eArgError, "Second argument is already erased");
			return Qnil;
		}
		if((EMSet*)bg->_M_node->_TZ_tree != (EMSet*)ed->_M_node->_TZ_tree){
			rb_raise(rb_eArgError, "First and second iterators are not from the same container");
			return Qnil;
		}
		VALUE res = Qnil;
		for(iterator it = *bg ; it != *ed ; ++it){
			if(it == ((EMSet*)bg->_M_node->_TZ_tree)->end()){
				rb_raise(rb_eRangeError, "Dereferencing the end iterator");
				return Qnil;
			}
			tov = toValue(*it);
			res = rb_yield(toValue(*it));
		}
		return res;
	}


	static VALUE eMSet_erase(int argc, VALUE *argv, VALUE self) {
		EMSet* p = eMSet(self);
		VALUE b, e;
		rb_scan_args(argc, argv, "11", &b, &e);
		if(!rb_obj_is_instance_of(b, cESetIt)){
			rb_raise(rb_eArgError, "First argument is not compatible type");
			return Qnil;
		}
		iterator* bg = eMSetIt(b), * ed;
		if(bg->_M_node->_TZ_destroyer){
			rb_raise(rb_eArgError, "First argument is already erased");
			return Qnil;
		}
		if((EMSet*)bg->_M_node->_TZ_tree != p){
			rb_raise(rb_eArgError, "First iterator is not from the method reciever's container");
			return Qnil;
		}
		if(argc == 2){
			if(!rb_obj_is_instance_of(e, cESetIt)){
				rb_raise(rb_eArgError, "Second argument is not compatible type");
				return Qnil;
			}
			ed = eMSetIt(e);
			if(ed->_M_node->_TZ_destroyer){
				rb_raise(rb_eArgError, "Second argument is already erased");
				return Qnil;
			}
			if((EMSet*)ed->_M_node->_TZ_tree != p){
				rb_raise(rb_eArgError, "Second iterator is not from the method reciever's container");
				return Qnil;
			}
		}
		switch(argc){
		case 1:
			p->erase(*bg);
			break;
		case 2:
			for(iterator it = *bg ; it != *ed ; ++it){
				if(it == ((EMSet*)bg->_M_node->_TZ_tree)->end()){
					rb_raise(rb_eRangeError, "Erasing over the end iterator");
					return Qnil;
				}
				p->erase(it);
			}
			break;
		}
		return Qnil;
	}

	static VALUE eMSet_clear(VALUE self) {
		EMSet* p = eMSet(self);
		p->clear();
		return self;
	}

	static void Init_eset(const char* cName){

		cESet = rb_define_class_under(rb_mYk, cName, rb_cObject);
		cESetIt = rb_define_class_under(cESet, "Iterator", rb_cObject);

		rb_define_alloc_func(cESet, ESetWrap<EMSet>::eMSet_alloc);
		rb_define_alloc_func(cESetIt, ESetWrap<EMSet>::eMSetIt_alloc);
		rb_define_method(cESet, "initialize", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSet_init), -1);
		rb_define_method(cESet, "size", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSet_size), 0);
		rb_define_method(cESet, "clear", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSet_clear), 0);

		rb_define_method(cESet, "each", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSet_each), 0);
		rb_define_method(cESet, "begin", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSet_begin), 0);
		rb_define_method(cESet, "end", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSet_end), 0);
		rb_define_method(cESet, "upper_bound", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSet_upper_bound), 1);
		rb_define_method(cESet, "lower_bound", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSet_lower_bound), 1);

		rb_define_method(cESetIt, "inc", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSetIt_inc), 0);
		rb_define_method(cESetIt, "end?", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSetIt_isEnd), 0);
		rb_define_method(cESetIt, "erased?", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSetIt_isErased), 0);
		rb_define_method(cESetIt, "dec", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSetIt_dec), 0);
		rb_define_method(cESetIt, "clone", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSetIt_clone), 0);
		rb_define_method(cESetIt, "==", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSetIt_eq), 1);
		rb_define_method(cESetIt, "!=", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSetIt_neq), 1);
		rb_define_method(cESetIt, "assign", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSetIt_assign), 1);

		rb_define_singleton_method(cESet, "find", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSet_find), -1);
		rb_define_method(cESet, "find", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSet_find1), 1);
		rb_define_method(cESet, "erase", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSet_erase), -1);
		rb_define_singleton_method(cESet, "for_each", RUBY_METHOD_FUNC(ESetWrap<EMSet>::eMSet_for_each), 2);
	}

};


template <typename EMSet>
VALUE ESetWrap<EMSet>::cESet = Qnil;
template <typename EMSet>
VALUE ESetWrap<EMSet>::cESetIt = Qnil;

template <typename E>
struct ESetWrapMap_ : ESetWrap<E>{
	static VALUE eMSet_insert(int argc, VALUE *argv, VALUE self){
		E* p = ESetWrap<E>::eMSet(self);
		VALUE a1, a2, a3;
		rb_scan_args(argc, argv, "21", &a1, &a2, &a3);
		if(argc == 2){
			decltype(p->insert(std::make_pair(a1, a2))) ret;
			ret = p->insert(std::make_pair(a1, a2));
			return ESetWrap<E>::insertRet(ret);
		}else{
			if(!rb_obj_is_instance_of(a1, ESetWrap<E>::cESetIt)){
				rb_raise(rb_eArgError, "First argument is not a compatible iterator");
				return Qnil;
			}
			typename E::iterator* iit = ESetWrap<E>::eMSetIt(a1);
			if((E*)(*iit)._M_node->_TZ_tree != p){
				rb_raise(rb_eArgError, "Referece iterator is not from the method reciever's container");
				return Qnil;
			}
			decltype(p->insert(*iit, std::make_pair(a2, a3))) ret;
			ret = p->insert(*iit, std::make_pair(a2, a3));
			return ESetWrap<E>::insertRet(ret);
		}
	}
	static VALUE eMSet_add(int argc, VALUE *argv, VALUE self){
		E* p = ESetWrap<E>::eMSet(self);
		VALUE a1, a2, a3;
		rb_scan_args(argc, argv, "21", &a1, &a2, &a3);
		if(argc == 2){
			decltype(p->insert(std::make_pair(a1, a2))) ret;
			ret = p->insert(std::make_pair(a1, a2));
			return ESetWrap<E>::addRet(ret);
		}else{
			if(!rb_obj_is_instance_of(a1, ESetWrap<E>::cESetIt)){
				rb_raise(rb_eArgError, "First argument is not a compatible iterator");
				return Qnil;
			}
			typename E::iterator* iit = ESetWrap<E>::eMSetIt(a1);
			if((E*)(*iit)._M_node->_TZ_tree != p){
				rb_raise(rb_eArgError, "Referece iterator is not from the method reciever's container");
				return Qnil;
			}
			decltype(p->insert(*iit, std::make_pair(a2, a3))) ret;
			ret = p->insert(*iit, std::make_pair(a2, a3));
			return ESetWrap<E>::addRet(ret);
		}
	}
	static VALUE eMSetIt_item(VALUE self) {
		typename E::iterator* it = ESetWrap<E>::eMSetIt(self);
		if(*it == ((E*)it->_M_node->_TZ_tree)->end()){
			rb_raise(rb_eRangeError, "Dereferencing the end iterator");
			return Qnil;
		}else{
			VALUE v[2] = {(*it)->first, (*it)->second};
			return rb_ary_new_from_values(2, (VALUE*)&v);
		}
	}
	static void Init_eset(const char* n){
		ESetWrap<E>::Init_eset(n);
		rb_define_method(ESetWrap<E>::cESet, "insert", RUBY_METHOD_FUNC(eMSet_insert), -1);
		rb_define_method(ESetWrap<E>::cESet, "add", RUBY_METHOD_FUNC(eMSet_add), -1);
		rb_define_method(ESetWrap<E>::cESetIt, "item", RUBY_METHOD_FUNC(eMSetIt_item), 0);
	};
};

template <typename EMSet>
struct ESetWrapMap : ESetWrapMap_<EMSet>{
};

template <>
struct ESetWrapMap<EMap> : ESetWrapMap_<EMap>{
	static VALUE eMSet_insert_or_assign(int argc, VALUE *argv, VALUE self){
		EMap* p = ESetWrap<EMap>::eMSet(self);
		VALUE a1, a2, a3;
		rb_scan_args(argc, argv, "21", &a1, &a2, &a3);
		if(argc == 2){
			std::pair<EMap::iterator, bool> ret;
			ret = p->insert(std::make_pair(a1, a2));
			if(!ret.second)
				ret.first->second = a2;
			return ESetWrap<EMap>::insertRet(ret);
		}else{
			if(!rb_obj_is_instance_of(a1, cESetIt)){
				rb_raise(rb_eArgError, "First argument is not an iterator");
				return Qnil;
			}
			iterator* iit = eMSetIt(a1);
			if((EMap*)(*iit)._M_node->_TZ_tree != p){
				rb_raise(rb_eArgError, "Referece iterator is not from the method reciever's container");
				return Qnil;
			}
			EMap::iterator ret;
			ret = p->insert(*iit, std::make_pair(a2, a3));
			if((*ret).second != a3)
				(*ret).second = a3;
			return ESetWrap<EMap>::insertRet(ret);
		}
	}
	static VALUE eMSet_add_or_assign(int argc, VALUE *argv, VALUE self){
		EMap* p = ESetWrap<EMap>::eMSet(self);
		VALUE a1, a2, a3;
		rb_scan_args(argc, argv, "21", &a1, &a2, &a3);
		if(argc == 2){
			std::pair<EMap::iterator, bool> ret;
			ret = p->insert(std::make_pair(a1, a2));
			if(!ret.second)
				ret.first->second = a2;
			return ESetWrap<EMap>::addRet(ret);
		}else{
			if(!rb_obj_is_instance_of(a1, cESetIt)){
				rb_raise(rb_eArgError, "First argument is not an iterator");
				return Qnil;
			}
			iterator* iit = eMSetIt(a1);
			if((EMap*)(*iit)._M_node->_TZ_tree != p){
				rb_raise(rb_eArgError, "Referece iterator is not from the method reciever's container");
				return Qnil;
			}
			EMap::iterator ret;
			ret = p->insert(*iit, std::make_pair(a2, a3));
			if((*ret).second != a3)
				(*ret).second = a3;
			return ESetWrap<EMap>::addRet(ret);
		}
	}
	static void Init_eset(const char* n){
		ESetWrapMap_<EMap>::Init_eset(n);
		rb_define_method(ESetWrap<EMap>::cESet, "insert_or_assign", RUBY_METHOD_FUNC(eMSet_insert_or_assign), -1);
		rb_define_method(ESetWrap<EMap>::cESet, "add_or_assign", RUBY_METHOD_FUNC(eMSet_add_or_assign), -1);
}	
};


template <typename EMSet>
struct ESetWrapSet : ESetWrap<EMSet>{
	static VALUE eMSet_insert(int argc, VALUE *argv, VALUE self){
		EMSet* p = ESetWrap<EMSet>::eMSet(self);
		VALUE a1, a2;
		rb_scan_args(argc, argv, "11", &a1, &a2);
		if(argc == 1){
			decltype(p->insert(a1)) ret;
			ret = p->insert(a1);
			return ESetWrap<EMSet>::insertRet(ret);
		}else{
			if(!rb_obj_is_instance_of(a1, ESetWrap<EMSet>::cESetIt)){
				rb_raise(rb_eArgError, "First argument is not an iterator");
				return Qnil;
			}
			typename EMSet::iterator* iit = ESetWrap<EMSet>::eMSetIt(a1);
			if((EMSet*)(*iit)._M_node->_TZ_tree != p){
				rb_raise(rb_eArgError, "Referece iterator is not from the method reciever's container");
				return Qnil;
			}
			decltype(p->insert(*iit, a2)) ret;
			ret = p->insert(*iit, a2);
			return ESetWrap<EMSet>::insertRet(ret);
		}
	}
	static VALUE eMSet_add(int argc, VALUE *argv, VALUE self){
		EMSet* p = ESetWrap<EMSet>::eMSet(self);
		VALUE a1, a2;
		rb_scan_args(argc, argv, "11", &a1, &a2);
		if(argc == 1){
			decltype(p->insert(a1)) ret;
			ret = p->insert(a1);
			return ESetWrap<EMSet>::addRet(ret);
		}else{
			if(!rb_obj_is_instance_of(a1, ESetWrap<EMSet>::cESetIt)){
				rb_raise(rb_eArgError, "First argument is not an iterator");
				return Qnil;
			}
			typename EMSet::iterator* iit = ESetWrap<EMSet>::eMSetIt(a1);
			if((EMSet*)(*iit)._M_node->_TZ_tree != p){
				rb_raise(rb_eArgError, "Referece iterator is not from the method reciever's container");
				return Qnil;
			}
			decltype(p->insert(*iit, a2)) ret;
			ret = p->insert(*iit, a2);
			return ESetWrap<EMSet>::addRet(ret);
		}
	}
	static VALUE eMSetIt_item(VALUE self) {
		typename EMSet::iterator* it = ESetWrap<EMSet>::eMSetIt(self);
		if(*it == ((EMSet*)it->_M_node->_TZ_tree)->end()){
			rb_raise(rb_eRangeError, "Dereferencing the end iterator");
			return Qnil;
		}else{
			return **it;
		}
	}
	static void Init_eset(const char* n){
		ESetWrap<EMSet>::Init_eset(n);
		rb_define_method(ESetWrap<EMSet>::cESet, "insert", RUBY_METHOD_FUNC(eMSet_insert), -1);
		rb_define_method(ESetWrap<EMSet>::cESet, "add", RUBY_METHOD_FUNC(eMSet_add), -1);
		rb_define_method(ESetWrap<EMSet>::cESetIt, "item", RUBY_METHOD_FUNC(eMSetIt_item), 0);
	};
};


extern "C" void Init_ESet(void){
	rb_mYk = rb_define_module("Yk");
	ID_CALL = rb_intern("call");
	ID_LESS = rb_intern("<");
	ID_EQ = rb_intern("==");
	ESetWrapSet<EMTSet>::Init_eset("EMSet");
	ESetWrapSet<ESet>::Init_eset("ESet");
	ESetWrapMap<EMTMap>::Init_eset("EMMap");
	ESetWrapMap<EMap>::Init_eset("EMap");
}


