!function(){var a={NODE:false,ENDER:false,either:function(b,c){if(a.NODE||!c){return b
}return c
},run:function(b,c){return a.either(b,c)()
}};
if(typeof module!=="undefined"&&typeof require!=="undefined"){a.NODE=true
}else{if(typeof require!=="undefined"&&typeof provide!=="undefined"){a.ENDER=true
}}a.run(function(){module.exports=a
},function(){provide("std::env",a)
})
}();
!function(){var a=require("underscore");
a.mixin({args:function(c,d,b){if(!d){d=0
}if(!b){b=c.length
}return Array.prototype.slice.call(c,d,b)
},log:function(b){if(typeof console!=="undefined"&&console.log){console.log(b)
}return b
},inherit:(function(){var b=function(){};
return function(d,c){b.prototype=d.prototype;
c.prototype=new b();
c.prototype.constructor=c;
a.extend(c,d);
return c
}
}()),nextTick:function(b){if(typeof process!=="undefined"&&process.nextTick){process.nextTick(b)
}else{if(typeof window!=="undefined"&&window.setImmediate){window.setImmediate(b)
}else{setTimeout(b,0)
}}},combine:function(){var b=a.chain(arguments).args().flatten().value();
return function(){var d=a.args(arguments),c=0,e=b.length;
for(c,e;
c<e;
c++){b[c].apply(null,d)
}}
},callback:function(){var b=a.chain(arguments).args().flatten().hashify().value().optional("ctx",null,{type:"object"}).required("callback").many("rest").end;
if(b.callback){b.callback.apply(b.ctx,b.rest)
}},hashify:(function(){var b=function(f,d,e){var h,g=false;
if(a.has(d,f)){h=d[f];
if(typeof h==="object"&&a.has(h,"not")){h=h[f];
g=true
}return !(g===e(h))
}return true
};
var c=function(m,h,i,e){var g=true,d="length",j=">"+d,l=">="+d,k="<"+d,f="<="+d;
if(typeof e==="function"){return e(m,h,i)
}if(typeof e==="boolean"){return e
}g=b("type",e,function(n){return typeof m===n
});
g=g&&b("instance",e,function(n){return m instanceof n
});
g=g&&b(d,e,function(n){return i.length===n
});
g=g&&b(j,e,function(n){return i.length>n
});
g=g&&b(l,e,function(n){return i.length>=n
});
g=g&&b(k,e,function(n){return i.length<n
});
g=g&&b(f,e,function(n){return i.length<=n
});
return g
};
return function(d){var e=0;
if(!a.isArray(d)){d=a.args(d)
}return{end:{},required:function(f){this.end[f]=d[e];
e++;
return this
},optional:function(h,g,f){var j=d[e],i=g,k=c(j,e,d,f);
if(k){e++;
i=j
}this.end[h]=i;
return this
},many:function(h,f){var i,g=[],j=true;
if(f){while(j&&e<d.length){i=d[e];
j=c(i,e,d,f);
if(j){e++;
g.push(i)
}}}else{g=d.slice(e)
}this.end[h]=g;
return this
}}
}
}())});
if(typeof provide!=="undefined"){provide("std::utils",a)
}else{module.exports=a
}}();
!function(){var a=typeof provide==="undefined"?require("./env"):require("std::env");
var b=require(a.either("./utils","std::utils"));
var c=function(){this._events={};
this._maxListeners=10
};
c.prototype.listeners=function(d){if(!this._events[d]){this._events[d]=[]
}return this._events[d]
};
c.prototype.setMaxListeners=function(d){this._maxListeners=d
};
c.prototype.on=c.prototype.addListener=function(d,f){this.emit("newListener",f);
var e=this.listeners(d);
e.push(f);
if(e.length>=this._maxListeners){b.log("Warning: "+this+" has more than "+this._maxListeners+" attached to event "+d+".")
}return this
};
c.prototype.once=function(d,e){var f={listener:e};
this.listeners(d).push(f);
this.emit("newListener",f);
return this
};
c.prototype.removeListener=function(d,g){var e,f=this.listeners(d);
for(e=0;
e<f.length;
e++){if(f[e]===g){f.splice(e,1);
break
}}return this
};
c.prototype.removeAllListeners=function(d){this._events[d]=[];
return this
};
c.prototype.emit=function(){var f,j,d=arguments[0],e=b.args(arguments,1),h=this._events[d]||[],i=h.length!==0,g=[];
for(f=0;
f<h.length;
f++){j=h[f];
if(typeof j==="object"){g.push(f);
j=j.listener
}j.apply(this,e)
}for(f=0;
f<g.length;
f++){h.splice(g[f]-f,1)
}return i
};
a.run(function(){module.exports=c
},function(){provide("std::emitter",c)
})
}();
!function(){var d=require(typeof provide==="undefined"?"./env":"std::env");
var k=require(d.either("./utils","std::utils"));
var o=d.run(function(){return require("events").EventEmitter
},function(){return require("std::emitter")
});
var c="done",f="cancel";
var j=function(v,y){var u,p,x,r,q,t=false,w=true,s=null;
this._internal={emitter:new o(),count:0,isDone:false,isCancelled:false,err:null,data:null,callback:y};
for(u=0,p=v.length;
u<p;
u++){x=v[u];
r=x._internal;
t=t||r.isCancelled;
s=r.err;
q=r.isDone&&!t;
w=w&&q;
if(t){break
}if(!q){this._internal.count++;
x.done(h(this));
x.cancel(i(this))
}}if(w){a(this)
}if(t){n(this,s)
}};
j.prototype.isDone=function(){return this._internal.isDone
};
j.prototype.isCancelled=function(){return this._internal.isCancelled
};
j.prototype.error=function(){return this._internal.err
};
j.prototype.data=function(){return this._internal.data
};
j.prototype.done=function(p){var q=this._internal;
if(!q.isCancelled){p=k.bind(p,this);
if(q.isDone){p(q.data)
}else{q.emitter.on(c,p)
}}return this
};
j.prototype.cancel=function(p){var q=this._internal;
if(!q.isDone){p=k.bind(p,this);
if(q.isCancelled){p(q.err)
}else{q.emitter.on(f,p)
}}return this
};
j.prototype.removeDone=function(p){this._internal.emitter.removeListener(c,p)
};
j.prototype.removeCancelled=function(p){this._internal.emitter.removeListener(f,p)
};
var a=function(q){var p=q._internal;
if(!p.isCancelled&&!p.isDone){p.callback.call(q,e(q),l(q))
}};
var m=function(q){var p=q._internal;
p.count--;
if(p.count===0){a(q)
}};
var g=function(r,p){var q=r._internal;
if(q.isDone||q.isCancelled){return
}q.isDone=true;
q.data=p;
q.emitter.emit(c,p);
q.emitter=new o()
};
var n=function(r,p){var q=r._internal;
if(q.isDone||q.isCancelled){return
}q.isCancelled=true;
q.err=p;
q.emitter.emit(f,p);
q.emitter=new o()
};
var h=function(p){return k.once(function(){m(p)
})
};
var i=function(p){return k.once(function(q){n(p,q)
})
};
var e=function(p){return k.once(function(q){g(p,q)
})
};
var l=function(p){return k.once(function(q){n(p,q)
})
};
var b=function(){var p=k.chain(arguments).args().flatten().hashify().value().many("dependencies",{instance:j}).required("callback").end;
return new j(p.dependencies,p.callback)
};
d.run(function(){module.exports=b
},function(){provide("std::wait",b)
})
}();
!function(){var a=require(typeof provide==="undefined"?"./env":"std::env");
var c=require(a.either("./wait","std::wait"));
var b=function(){this._internal={promise:c(function(d){d()
})}
};
b.prototype.enqueue=function(d){var f=this._internal;
var e=f.promise=c(f.promise,d);
e.cancel(function(){if(f.promise===this){f.promise=c(function(g){g()
})
}});
return e
};
b.prototype.top=function(){return this._internal.promise
};
if(typeof provide==="undefined"){module.exports=b
}else{provide("std::async-queue",b)
}}();
!function(){var a=require(typeof provide==="undefined"?"./env":"std::env");
var m=a.run(function(){return require("events").EventEmitter
},function(){return require("std::emitter")
});
var k=require(a.either("./utils","std::utils")),e=require(a.either("./wait","std::wait"));
var f="set:",h="destroy:",j="invalidate:",g="change:";
var i=k.inherit(m,function(){m.call(this);
this._data={};
this._loading={};
l(this)
});
i.serialize=function(q,n){var p,o;
this.serial=this.serial||{};
o=this.serial[q]=this.serial[q]||{};
for(p in n){if(k.has(n,p)){o[p]=n[p]
}}};
i.prototype.get=function(n,o){if(o){if(this._data.hasOwnProperty(n)){o(null,this._data[n])
}else{this.load(n,o)
}}else{return d(this,[],n)
}};
function d(n,q,o){var p=e(q,function(r,s){n=typeof n==="function"?n():n;
n.get(o,function(t,u){t?s(t):r(u)
})
});
p.get=function(s,t){var r=function(){return p.data()
};
if(s&&t){p.done(function(u){r().get(s,t)
});
p.cancel(function(u){t(u)
});
return
}return d(r,[p],s)
};
return p
}i.prototype.invalidate=function(n,q){var p=this;
if(k.has(this._data,n)){delete this._data[n]
}var o=e(function(r,s){p.load(n,function(t,u){if(t){s(t)
}else{r(u)
}if(q){q(t,u)
}})
});
this.emit(j+n,o)
};
i.prototype.load=function(o,q){var p=this,n=this._data[o];
if(this._loading[o]){this._loading[o].push(q);
return
}this._loading[o]=[];
if(q){this._loading[o].push(q)
}b(this,"get",o,function(r,s){if(!r){p._data[o]=s;
p.emit(g+o,n,s);
k.each(p._loading[o],function(t){t.call(p,null,s)
})
}else{k.each(p._loading[o],function(t){t.call(p,r)
})
}delete p._loading[o]
})
};
i.prototype.set=function(o,p,q){var n=this._data[o];
if(n!==p){this._data[o]=p;
this.emit(f+o,n,p);
this.emit(g+o,n,p);
b(this,"set",o,q)
}else{k.callback(q,null,p)
}};
i.prototype.destroy=function(n,o){if(this._data.hasOwnProperty(n)){delete this._data[n];
this.emit(h+n,value);
b(this,"destroy",n,o)
}else{k.callback(o,null)
}};
var l=function(n){var r,q,p=n.constructor,o=p.serial;
if(o){for(r in o){if(k.has(o,r)){c(n,o[r],r)
}}}};
var c=function(n,o,p){if(k.has(o,"init")){o.init.call(n,function(q,r){if(!q){n._data[p]=r
}else{k.log(q)
}})
}};
var b=function(n,s,q,t){var r,p=n.constructor,o=p.serial;
if(o){if(k.has(o,q)){r=o[q];
if(k.has(r,s)){k.nextTick(function(){r[s].call(n,t)
});
return
}}}k.nextTick(function(){k.callback(n,t,"No serializer!",null)
})
};
a.run(function(){module.exports=i
},function(){provide("std::cache",i)
})
}();
!function(){var a=require(typeof provide==="undefined"?"./env":"std::env");
var e=a.run(function(){return require("events").EventEmitter
},function(){return require("std::emitter")
});
var b=require(a.either("./utils","std::utils"));
var d=b.inherit(e,function(g,f){e.call(this);
this.time=g||0;
this._internal={on:false,looping:f||false}
});
d.prototype.start=function(){if(!this._internal.on){this._internal.on=true;
this._internal.countdown=0;
this.emit("start");
c(this,this.time)
}};
d.prototype.stop=function(){if(this._internal.on){this._internal.on=false;
this._internal.countdown=0;
this.emit("stop")
}};
var c=function(h,g){var f=new Date;
setTimeout(function(){var j=(new Date)-f,i=h._internal;
if(i.on){h.emit("tick",j,g);
if(i.looping){c(h,g)
}else{h.stop()
}}},g)
};
a.run(function(){module.exports=d
},function(){provide("std::alarm",d)
})
}();
!function(){var a=require(typeof provide==="undefined"?"./env":"std::env");
var c=a.run(function(){return require("./alarm")
},function(){return require("std::alarm")
});
function b(e){this._internal={a:new c(e,true)};
this._internal.a.start()
}b.prototype.setInterval=function(e,f){var g=d(e,f);
this._internal.a.on("tick",g);
return g
};
b.prototype.clearInterval=function(e){this._internal.a.removeListener("tick",e)
};
b.prototype.setTimeout=function(e,g){var f=this;
var h=d(function(){f._internal.a.removeListener("tick",h);
e()
},g);
h._isTimeout=true;
this._internal.a.on("tick",h);
return h
};
b.prototype.clearTimeout=function(h){if(h){this._internal.a.removeListener("tick",h)
}else{var g,i,j,e=this._internal.a.listeners("tick"),f=[];
for(g=0,i=e.length;
g<i;
g++){j=e[g];
if(j._isTimeout){f.push(j)
}}for(g=0,i=f.length;
g<i;
g++){this._internal.a.removeListener("tick",f[g])
}}};
b.prototype.start=function(){this._internal.a.start()
};
b.prototype.stop=function(){this._internal.a.stop()
};
function d(f,g){var e=0;
return function(h){e+=h;
if(e>=g){e-=g;
f()
}}
}a.run(function(){module.exports=b
},function(){provide("std::timing",b)
})
}();
require=function(h,g,l){function k(e,d){if(!g[e]){if(!h[e]){var b="function"==typeof require&&require;
if(!d&&b){return b(e,!0)
}if(j){return j(e,!0)
}throw new Error("Cannot find module '"+e+"'")
}var a=g[e]={exports:{}};
h[e][0].call(a.exports,function(c){var f=h[e][1][c];
return k(f?f:c)
},a,a.exports)
}return g[e].exports
}for(var j="function"==typeof require&&require,i=0;
i<l.length;
i++){k(l[i])
}return k
}({1:[function(d,c){c.exports=function(){function b(){}return b.prototype.on=function(f,e){f&&e&&(this.queue||(this.queue={}),this.queue[f]||(this.queue[f]=[]),this.queue[f].push(e))
},b.prototype.off=function(f,e){return f?(this.queue&&this.queue[f]&&(this.queue[f]=e?this.queue[f].filter(function(g){return g!==e
}):[]),void 0):(this.queue={},void 0)
},b.prototype.emit=function(f){var e=Array.prototype.slice.call(arguments,1);
f&&this.queue&&this.queue[f]&&this.queue[f].forEach(function(g){g.apply(this,e)
},this)
},b.mixin=function(a){Object.keys(b.prototype).forEach(function(e){a.prototype[e]=b.prototype[e]
})
},b
}
},{}],2:[function(d,c){c.exports=function(f,e){function g(a,h){if(!a){throw new Error
}if(h||(h=g.defaultOptions),this.$element=f(a),1!==this.$element.length||this.$element.data()["o2-modal"]){throw new Error
}if(this.$trigger=f(h.trigger),1!==this.$trigger.length){this.$trigger=f()
}else{if(this.$trigger.data()["o2-modal"]){throw new Error
}}this.$container=f(h.container),1!==this.$container.length&&(this.$container=f("body")),1!==this.$element.closest(this.$container).length&&this.$element.appendTo(this.$container),"undefined"==typeof this.$container.data()["o2-modal-instances"]&&(this.$container.data()["o2-modal-instances"]=[],this.$container.data()["o2-modal-open"]=0),this.$container.is("body")||this.$element.addClass("modal-absolute"),this.$element.attr("aria-hidden","true").reflow().on("click.o2-modal",'[data-behavior="modal-close"]',this.close.bind(this)),this.$trigger.on("click.o2-modal",this.open.bind(this)),h.sticky||(this.$element.on("click.o2-modal",function(i){f(i.target).is(".modal-cell")&&this.close(i)
}.bind(this)),this.$container.on("keyup.o2-modal",function(i){var j=27;
i.which===j&&f(i.target).is(":not(input)")&&this.close()
}.bind(this))),this.$element.data()["o2-modal"]=this,this.$trigger.length&&(this.$trigger.data()["o2-modal"]=this),this.$container.data()["o2-modal-instances"].push(this)
}return e.mixin(g),g.defaultOptions={sticky:!1},g.bind=function(a){var i=this,h=[];
return f(a||"body").find('[role="dialog"]').each(function(){var j=f(this),n=f(j.data("trigger")),m=f(j.data("container")),l=!!j.data("sticky");
if(!j.data()["o2-modal"]){try{h.push(new i(j,{trigger:n,container:m,sticky:l}))
}catch(k){}}}),h
},g.prototype.open=function(b){b&&b.preventDefault(),"true"===this.$element.attr("aria-hidden")&&this.$element.attr("aria-hidden","false").afterTransition(function(){this.$element.reflow(),0===this.$container.data()["o2-modal-open"]++&&this.$container.addClass("modal-open"),this.emit("open",this)
}.bind(this))
},g.prototype.close=function(b){b&&b.preventDefault(),"false"===this.$element.attr("aria-hidden")&&this.$element.removeAttr("aria-hidden").afterTransition(function(){this.$element.attr("aria-hidden","true").reflow(),1===this.$container.data()["o2-modal-open"]--&&this.$container.removeClass("modal-open"),this.emit("close",this,b)
}.bind(this))
},g.prototype.dispose=function(){this.close(null),delete this.$element.data()["o2-modal"],this.$element.removeClass("modal-absolute").removeAttr("aria-hidden").off(".o2-modal").detach(),this.$trigger.length&&delete this.$trigger.data()["o2-modal"],this.$trigger.off(".o2-modal"),this.$container.data()["o2-modal-instances"]=this.$container.data()["o2-modal-instances"].filter(function(b){return b!==this
}.bind(this)),0===this.$container.data()["o2-modal-instances"].length&&(delete this.$container.data()["o2-modal-instances"],delete this.$container.data()["o2-modal-open"],this.$container.off(".o2-modal"))
},g
}
},{}],3:[function(d,c){c.exports=function(f,e,h){function g(a,j){if(j&&(!/^#./.test(j)||!f(j).length)){throw new Error("The data-transition-at attribute value must be an id")
}var i=f.proxy(this.process,this);
this.$body=f("body"),this.$scrollElement=f(h),this.$placeholderElement=f('<div class="subnav-placeholder">'),this.$navigationElement=f(a),this.$transitionElement=j?f(j):this.$navigationElement,this.transitionOffset=this.$transitionElement.offset().top,this.offsets=[],this.targets=[],this.isContextual=!!j,this.isPinned=!1,this.activeTarget=null,this.isContextual||this.$placeholderElement.insertAfter(this.$navigationElement),this.refresh(),this.process(),this.$scrollElement.on("scroll",i)
}return g.bind=function(a){var j=this,i=[];
return f(a||"body").find('.subnav[data-sticky="true"]').each(function(){var k=f(this),l=new j(this,k.data("transition-at")||null);
i.push(l)
}),i
},g.prototype.getScrollHeight=function(){return this.$scrollElement[0].scrollHeight||this.$body[0].scrollHeight
},g.prototype.refresh=function(){var a=this,i=-5;
this.offsets=[],this.targets=[],this.scrollHeight=this.getScrollHeight(),this.$navigationElement.find("a").map(function(){var j=f(this),l=j.attr("href"),k=/^#./.test(l)&&f(l);
return k&&k.length&&k.is(":visible")?[[k.offset().top,l]]:null
}).sort(function(k,j){return k[0]-j[0]
}).each(function(){a.offsets.push(Math.max(this[0]+i,0)),a.targets.push(this[1])
}),this.$placeholderElement.height(this.$transitionElement.outerHeight())
},g.prototype.process=function(){var r,q=this.$scrollElement.scrollTop(),p=this.getScrollHeight(),o=p-this.$scrollElement.height(),n=this.offsets,m=this.targets,l=this.transitionOffset,k=this.activeTarget,j=this.isPinned;
if(this.scrollHeight!==p&&this.refresh(),(q>=l&&!j||l>q&&j)&&this.togglePinned(),m.length&&q>=o){return k!==(r=m[m.length-1])&&this.activate(r)
}if(m.length&&k&&q<=n[0]){return k!==(r=m[0])&&this.activate(r)
}for(r=n.length;
r--;
){k!==m[r]&&q>=n[r]&&(!n[r+1]||q<=n[r+1])&&this.activate(m[r])
}},g.prototype.togglePinned=function(){var j=this.isPinned,i=this.isContextual;
i?this.$navigationElement.attr("aria-hidden",j):(this.$navigationElement.toggleClass("pinned",!j),this.$placeholderElement.toggleClass("placeholding",!j)),this.isPinned=!j
},g.prototype.activate=function(j){var i=this.$navigationElement;
this.activeTarget=j,i.find('[aria-selected="true"]').attr("aria-selected","false"),i.find('[href="'+j+'"]').attr("aria-selected","true")
},g
}
},{}],4:[function(d,c){c.exports=function(g,f,j){function i(a){if(!a){throw new Error
}var l=j&&j.location&&j.location.hash||null;
if(this.$element=g(a),1!==this.$element.length||this.$element.data()["o2-tabs"]){throw new Error
}if(this.$element.on("click.o2-tabs",'[role="tab"]',this.activateTarget.bind(this)).data()["o2-tabs"]=this,l){var k=l.substring(1),e=this.$element.find('[aria-controls="'+k+'"]');
e.length&&!h(e)&&this.activate(k)
}}function h(b){return"true"===b.attr("aria-disabled")
}return f.mixin(i),i.bind=function(a){var k=this,e=[];
return g(a||"body").find('[role="tablist"]').each(function(){if(!g(this).data()["o2-tabs"]){try{e.push(new k(g(this)))
}catch(l){}}}),e
},i.prototype.activateTarget=function(a){var e=g(a.currentTarget);
a.preventDefault(),h(e)||this.activate(g(a.currentTarget).attr("aria-controls"))
},i.prototype.activate=function(a){var o,n,m,l,k;
a&&(n=g("#"+a),l=this.$element.find('[aria-controls="'+a+'"]'),1===n.length&&1===l.length&&(k=this.$element.find('[aria-selected="true"]'),o=k.attr("aria-controls"),m=g(o?"#"+o:""),o!==a&&(m.attr("aria-hidden","true").reflow(),n.attr("aria-hidden","false").reflow(),k.attr("aria-selected","false").reflow(),l.attr("aria-selected","true").reflow(),j.history.replaceState&&"true"===this.$element.data("permalink")&&j.history.replaceState(null,null,"#"+a),this.emit("activate",this,a))))
},i.prototype.dispose=function(){delete this.$element.data()["o2-tabs"],this.$element.off(".o2-tabs")
},i
}
},{}],5:[function(d,c){c.exports=function(f,e){function g(a,j,i){var h;
if(this._timeout=null,this._delay=200,!a||!j){throw new Error
}if(i||(i={}),this.$element=f(a),this.$trigger=f(j),this.sticky=!!i.sticky,1!==this.$element.length||1!==this.$trigger.length||this.$element.data()["o2-tooltip"]||this.$trigger.data()["o2-tooltip"]){throw new Error
}switch(this.$element.appendTo(f("body")),h=this.$trigger.attr("title"),h&&(this.$trigger.attr("aria-label",h),this.$trigger.removeAttr("title")),this.$element.attr("aria-hidden","true").reflow(),i.event){case"none":break;
case"click":this.$trigger.on("click.o2-tooltip",this.toggle.bind(this));
break;
default:this.$trigger.on("mouseenter.o2-tooltip",this.show.bind(this)).on("mouseleave.o2-tooltip",this.hide.bind(this)),this.sticky&&this.$element.on("mouseenter.o2-tooltip",this.clearTimeout.bind(this)).on("mouseleave.o2-tooltip",this.hide.bind(this))
}this.$element.data()["o2-tooltip"]=this,this.$trigger.data()["o2-tooltip"]=this
}return e.mixin(g),g.template='<div class="tooltip {{position}}" role="tooltip">  <p class="panel-body">{{text}}</p></div>',g.bind=function(a){var i=this,h=[];
return a=a||"body",f(a).find('[role="tooltip"]').each(function(){var j=f(this),n=f(j.data("trigger")),m=!!j.data("sticky"),l=j.data("event");
if(!j.data()["o2-tooltip"]){try{h.push(new i(j,n,{event:l,sticky:m}))
}catch(k){}}}),f(a).find('[data-behavior="tooltip"][title]').each(function(){var m,t,s=f(this),r=s.data("position"),q=s.data("event"),p=!!s.data("sticky"),o=s.attr("title");
if(!s.data()["o2-tooltip"]){switch(r){case"bottom":t="tooltip-top-middle";
break;
case"right":t="tooltip-left-middle";
break;
case"left":t="tooltip-right-middle";
break;
default:t="tooltip-bottom-middle"
}m=f(g.template.replace("{{position}}",t).replace("{{text}}",o)).appendTo(s.parent());
try{h.push(new i(m,s,{event:q,sticky:p}))
}catch(n){}}}),h
},g.prototype.show=function(b){b&&b.preventDefault(),"true"===this.$element.attr("aria-hidden")&&(this.initializePosition(),this.$element.attr("aria-hidden","false").reflow(),this.emit("show",this))
},g.prototype.hide=function(i){if(i&&i.preventDefault(),this.clearTimeout(),"false"===this.$element.attr("aria-hidden")){var h=function(){this.$element.removeAttr("aria-hidden").afterTransition(function(){this.$element.attr("aria-hidden","true").reflow(),this.emit("hide",this,i)
}.bind(this))
}.bind(this);
this.sticky?this._timeout=setTimeout(h,this._delay):h()
}},g.prototype.clearTimeout=function(){this._timeout&&(clearTimeout(this._timeout),this._timeout=null)
},g.prototype.toggle=function(b){"true"===this.$element.attr("aria-hidden")?this.show(b):this.hide(b)
},g.prototype.dispose=function(){this.hide(null),delete this.$element.data()["o2-tooltip"],this.$element.removeAttr("aria-hidden").detach(),delete this.$trigger.data()["o2-tooltip"],this.$trigger.off(".o2-tooltip")
},g.caretSize=12,g.prototype.initializePosition=function(){var i,h,l,k={},j=["top","bottom","left","right"];
for(h={height:parseInt(this.$trigger.attr("height")||this.$trigger.css("height"),10),width:parseInt(this.$trigger.attr("width")||this.$trigger.css("width"),10),offset:this.$trigger.offset()},l={height:parseInt(this.$element.css("height"),10),width:parseInt(this.$element.css("width"),10),classes:this.$element.attr("class").split(" ")},i=0;
i<l.classes.length&&(0!==l.classes[i].indexOf("tooltip-")||(l.classes=l.classes[i].split("-").slice(1),-1===j.indexOf(l.classes[0])));
i++){}switch(l.classes[0]){case"top":k.top=h.offset.top+h.height+g.caretSize;
break;
case"bottom":k.top=h.offset.top-l.height-g.caretSize;
break;
case"left":k.left=h.offset.left+h.width+g.caretSize;
break;
case"right":k.left=h.offset.left-l.width-g.caretSize;
break;
default:throw new Error
}if(k.hasOwnProperty("top")){switch(l.classes[1]){case"left":k.left=h.offset.left;
break;
case"middle":k.left=h.offset.left+h.width/2-l.width/2;
break;
case"right":k.left=h.offset.left+h.width-l.width;
break;
default:throw new Error
}}else{switch(l.classes[1]){case"top":k.top=h.offset.top;
break;
case"middle":k.top=h.offset.top+h.height/2-l.height/2;
break;
case"bottom":k.top=h.offset.top+h.height-l.height;
break;
default:throw new Error
}}this.$element.css(k)
},g
}
},{}],Iwb2Ll:[function(d,c){c.exports=function(r,q){function p(f){var e=[];
return e=e.concat(m.bind(f)),e=e.concat(l.bind(f)),e=e.concat(k.bind(f)),e=e.concat(a.bind(f))
}function o(){q(window).off("load.o2")
}var n=d("./emitter")(),m=d("./modules/modal")(q,n),l=d("./modules/subnav")(q,n,r),k=d("./modules/tabs")(q,n,r),a=d("./modules/tooltip")(q,n);
return d("./transitions")(r,q),d("./reflow")(q),q(window).on("load.o2",p.bind(this,null)),{bind:p,suppressBind:o,Modal:m,SubNav:l,Tabs:k,Tooltip:a}
}(window,$)
},{"./emitter":1,"./modules/modal":2,"./modules/subnav":3,"./modules/tabs":4,"./modules/tooltip":5,"./reflow":7,"./transitions":8}],7:[function(d,c){c.exports=function(b){return b.fn.reflow?b:(b.extend(b.fn,{reflow:function(){return this.each(function(){b(this).addClass("o2-reflow").removeClass("o2-reflow").height()
}),this
}}),b)
}
},{}],8:[function(d,c){c.exports=function(f,e){return e.Transitions?e:(e.Transitions={timeout:600,events:{transition:"transitionend",OTransition:"oTransitionEnd",WebkitTransition:"webkitTransitionEnd",MozTransition:"transitionend"},eventName:function(){var h,g=!1;
for(h in this.events){if("undefined"!=typeof document.body.style[h]){g=this.events[h];
break
}}return this.eventName=function(){return g
},g
},supported:function(){return this.eventName()!==!1
}},e.extend(e.fn,{afterTransition:function(h,g){var b,a;
return g=Number(g),(!g||0>g)&&(g=e.Transitions.timeout),"function"!=typeof h&&(h=function(){}),b=e.Transitions.eventName(),this.each(function(){if(a=e.Event("transitionend"),a.target=a.currentTarget=this,b){var l,k=!1,j=function(i){k||(k=!0,h.call(this,i||a),e(this).off(b,j),f.clearTimeout(l))
}.bind(this);
e(this).on(b,j),l=f.setTimeout(j,g)
}else{h.call(this,a)
}}),this
}}),e)
}
},{}],o2:[function(d,c){c.exports=d("Iwb2Ll")
},{}]},{},["Iwb2Ll"]);
!function(c){function d(){}provide("o2-tooltip",d);
var b=(function(j,g){var h=false,i,k;
function f(m){var n=h;
if(!m){return f
}m=j(m);
if(m.is(k)){return f
}k=m;
if(!m.hasClass("modal-content")){m=m.removeClass("modal").addClass("modal-content").wrap('<div class="modal"><div class="modal-table"><div class="modal-cell"></div></div></div>')
}while(m.length&&!m.hasClass("modal")){m=m.parent()
}function l(o){return function(p){if(p===i){h=o
}k.trigger("modalTransitionStart",o).trigger("modalTransitionEnd",o).trigger(o?"modalOpen":"modalClose")
}
}if(n){i.close()
}i=m.data("o2-modal");
if(!i){i=new g(m,{sticky:k.hasClass("modal-sticky")});
i.on("open",l(true));
i.on("close",l(false))
}if(n){i.open()
}return f
}f.bind=function(){j("body").on("click",'.modal .close, .modal [data-modal-close="true"]',function(l){l.preventDefault();
f.close()
}).on("click",'a[rel="modal"]',function(l){l.preventDefault();
f(j(this).attr("href")).open()
})
};
f._toggle=function(m,n){function l(){if(typeof n==="function"){n()
}}if(h!==m){h=m;
if(k){k.one("modalTransitionEnd",l)
}if(i){i[m?"open":"close"]()
}}else{l()
}return f
};
f.open=function(l){return f._toggle(true,l)
};
f.close=function(l){return f._toggle(false,l)
};
f.toggle=function(l){return f._toggle(!h,l)
};
f.current=function(){return k
};
f.isOpen=function(){return h
};
return f
})(c,require("o2").Modal);
provide("o2-modal",b);
var e=(function(f){return{bind:function(){f("body").on("click",'[data-collapsible-role="toggle"]',function(j){var g=f(j.currentTarget),k=f(g.attr("href")),h=g.find('[data-collapsible-role="icon"]'),i=!h.hasClass("icon-caret-right");
if(k.length){j.preventDefault();
k.toggle();
h.toggleClass("icon-caret-right",i);
h.toggleClass("icon-caret-down",!i)
}})
}}
})(c);
var a=(function(g){function f(h){if(!h){throw new Error()
}this.$element=g(h);
if(this.$element.length!==1){throw new Error()
}this.$element.data("dropdown",this)
}f.bind=function(h){var j=[];
h=h||"body";
function i(m){var l,k;
for(l=0;
l<j.length;
l++){k=j[l];
if(m!==k){k.hide()
}}}g(h).find(".dropdown-toggle").each(function(){var n=g(this),k=n.parent(),l=k.find(".dropdown-menu"),o;
if(k.data("dropdown")){return
}try{o=new f(k)
}catch(m){}if(o){l.on("click",function(p){if(p.originalEvent){p.originalEvent.dropdown=o
}});
n.on("click",function(p){p.stopPropagation();
i(o);
o.toggle()
});
j.push(o)
}});
g(h).on("click",function(k){k.originalEvent=k.originalEvent||{};
i(k.originalEvent.dropdown)
})
};
f.prototype.show=function(h){if(h){h.preventDefault()
}if(this.$element.hasClass("open")){return
}this.$element.addClass("open");
this.$element.find(".icon-caret-up").removeClass("hide");
this.$element.find(".icon-caret-down").addClass("hide")
};
f.prototype.hide=function(h){if(h){h.preventDefault()
}if(!this.$element.hasClass("open")){return
}this.$element.removeClass("open");
this.$element.find(".icon-caret-down").removeClass("hide");
this.$element.find(".icon-caret-up").addClass("hide")
};
f.prototype.toggle=function(h){if(!this.$element.hasClass("open")){this.show(h)
}else{this.hide(h)
}};
return f
})(c);
provide("o2-dropdown",a);
c(window).on("load",function(){b.bind();
e.bind();
a.bind()
})
}($);
function FastClick(b){var c,a=this;
this.trackingClick=false;
this.trackingClickStart=0;
this.targetElement=null;
this.touchStartX=0;
this.touchStartY=0;
this.lastTouchIdentifier=0;
this.touchBoundary=10;
this.layer=b;
if(!b||!b.nodeType){throw new TypeError("Layer must be a document node")
}this.onClick=function(){return FastClick.prototype.onClick.apply(a,arguments)
};
this.onMouse=function(){return FastClick.prototype.onMouse.apply(a,arguments)
};
this.onTouchStart=function(){return FastClick.prototype.onTouchStart.apply(a,arguments)
};
this.onTouchMove=function(){return FastClick.prototype.onTouchMove.apply(a,arguments)
};
this.onTouchEnd=function(){return FastClick.prototype.onTouchEnd.apply(a,arguments)
};
this.onTouchCancel=function(){return FastClick.prototype.onTouchCancel.apply(a,arguments)
};
if(FastClick.notNeeded(b)){return
}if(this.deviceIsAndroid){b.addEventListener("mouseover",this.onMouse,true);
b.addEventListener("mousedown",this.onMouse,true);
b.addEventListener("mouseup",this.onMouse,true)
}b.addEventListener("click",this.onClick,true);
b.addEventListener("touchstart",this.onTouchStart,false);
b.addEventListener("touchmove",this.onTouchMove,false);
b.addEventListener("touchend",this.onTouchEnd,false);
b.addEventListener("touchcancel",this.onTouchCancel,false);
if(!Event.prototype.stopImmediatePropagation){b.removeEventListener=function(e,g,d){var f=Node.prototype.removeEventListener;
if(e==="click"){f.call(b,e,g.hijacked||g,d)
}else{f.call(b,e,g,d)
}};
b.addEventListener=function(f,g,e){var d=Node.prototype.addEventListener;
if(f==="click"){d.call(b,f,g.hijacked||(g.hijacked=function(h){if(!h.propagationStopped){g(h)
}}),e)
}else{d.call(b,f,g,e)
}}
}if(typeof b.onclick==="function"){c=b.onclick;
b.addEventListener("click",function(d){c(d)
},false);
b.onclick=null
}}FastClick.prototype.deviceIsAndroid=navigator.userAgent.indexOf("Android")>0;
FastClick.prototype.deviceIsIOS=/iP(ad|hone|od)/.test(navigator.userAgent);
FastClick.prototype.deviceIsIOS4=FastClick.prototype.deviceIsIOS&&(/OS 4_\d(_\d)?/).test(navigator.userAgent);
FastClick.prototype.deviceIsIOSWithBadTarget=FastClick.prototype.deviceIsIOS&&(/OS ([6-9]|\d{2})_\d/).test(navigator.userAgent);
FastClick.prototype.needsClick=function(a){switch(a.nodeName.toLowerCase()){case"button":case"select":case"textarea":if(a.disabled){return true
}break;
case"input":if((this.deviceIsIOS&&a.type==="file")||a.disabled){return true
}break;
case"label":case"video":return true
}return(/\bneedsclick\b/).test(a.className)
};
FastClick.prototype.needsFocus=function(a){switch(a.nodeName.toLowerCase()){case"textarea":return true;
case"select":return !this.deviceIsAndroid;
case"input":switch(a.type){case"button":case"checkbox":case"file":case"image":case"radio":case"submit":return false
}return !a.disabled&&!a.readOnly;
default:return(/\bneedsfocus\b/).test(a.className)
}};
FastClick.prototype.sendClick=function(b,c){var a,d;
if(document.activeElement&&document.activeElement!==b){document.activeElement.blur()
}d=c.changedTouches[0];
a=document.createEvent("MouseEvents");
a.initMouseEvent(this.determineEventType(b),true,true,window,1,d.screenX,d.screenY,d.clientX,d.clientY,false,false,false,false,0,null);
a.forwardedTouchEvent=true;
b.dispatchEvent(a)
};
FastClick.prototype.determineEventType=function(a){if(this.deviceIsAndroid&&a.tagName.toLowerCase()==="select"){return"mousedown"
}return"click"
};
FastClick.prototype.focus=function(a){var b;
if(this.deviceIsIOS&&a.setSelectionRange&&a.type.indexOf("date")!==0&&a.type!=="time"){b=a.value.length;
a.setSelectionRange(b,b)
}else{a.focus()
}};
FastClick.prototype.updateScrollParent=function(b){var c,a;
c=b.fastClickScrollParent;
if(!c||!c.contains(b)){a=b;
do{if(a.scrollHeight>a.offsetHeight){c=a;
b.fastClickScrollParent=a;
break
}a=a.parentElement
}while(a)
}if(c){c.fastClickLastScrollTop=c.scrollTop
}};
FastClick.prototype.getTargetElementFromEventTarget=function(a){if(a.nodeType===Node.TEXT_NODE){return a.parentNode
}return a
};
FastClick.prototype.onTouchStart=function(c){var a,d,b;
if(c.targetTouches.length>1){return true
}a=this.getTargetElementFromEventTarget(c.target);
d=c.targetTouches[0];
if(this.deviceIsIOS){b=window.getSelection();
if(b.rangeCount&&!b.isCollapsed){return true
}if(!this.deviceIsIOS4){if(d.identifier===this.lastTouchIdentifier){c.preventDefault();
return false
}this.lastTouchIdentifier=d.identifier;
this.updateScrollParent(a)
}}this.trackingClick=true;
this.trackingClickStart=c.timeStamp;
this.targetElement=a;
this.touchStartX=d.pageX;
this.touchStartY=d.pageY;
if((c.timeStamp-this.lastClickTime)<200){c.preventDefault()
}return true
};
FastClick.prototype.touchHasMoved=function(a){var c=a.changedTouches[0],b=this.touchBoundary;
if(Math.abs(c.pageX-this.touchStartX)>b||Math.abs(c.pageY-this.touchStartY)>b){return true
}return false
};
FastClick.prototype.onTouchMove=function(a){if(!this.trackingClick){return true
}if(this.targetElement!==this.getTargetElementFromEventTarget(a.target)||this.touchHasMoved(a)){this.trackingClick=false;
this.targetElement=null
}return true
};
FastClick.prototype.findControl=function(a){if(a.control!==undefined){return a.control
}if(a.htmlFor){return document.getElementById(a.htmlFor)
}return a.querySelector("button, input:not([type=hidden]), keygen, meter, output, progress, select, textarea")
};
FastClick.prototype.onTouchEnd=function(c){var e,d,b,g,f,a=this.targetElement;
if(!this.trackingClick){return true
}if((c.timeStamp-this.lastClickTime)<200){this.cancelNextClick=true;
return true
}this.cancelNextClick=false;
this.lastClickTime=c.timeStamp;
d=this.trackingClickStart;
this.trackingClick=false;
this.trackingClickStart=0;
if(this.deviceIsIOSWithBadTarget){f=c.changedTouches[0];
a=document.elementFromPoint(f.pageX-window.pageXOffset,f.pageY-window.pageYOffset)||a;
a.fastClickScrollParent=this.targetElement.fastClickScrollParent
}b=a.tagName.toLowerCase();
if(b==="label"){e=this.findControl(a);
if(e){this.focus(a);
if(this.deviceIsAndroid){return false
}a=e
}}else{if(this.needsFocus(a)){if((c.timeStamp-d)>100||(this.deviceIsIOS&&window.top!==window&&b==="input")){this.targetElement=null;
return false
}this.focus(a);
if(!this.deviceIsIOS4||b!=="select"){this.targetElement=null;
c.preventDefault()
}return false
}}if(this.deviceIsIOS&&!this.deviceIsIOS4){g=a.fastClickScrollParent;
if(g&&g.fastClickLastScrollTop!==g.scrollTop){return true
}}if(!this.needsClick(a)){c.preventDefault();
this.sendClick(a,c)
}return false
};
FastClick.prototype.onTouchCancel=function(){this.trackingClick=false;
this.targetElement=null
};
FastClick.prototype.onMouse=function(a){if(!this.targetElement){return true
}if(a.forwardedTouchEvent){return true
}if(!a.cancelable){return true
}if(!this.needsClick(this.targetElement)||this.cancelNextClick){if(a.stopImmediatePropagation){a.stopImmediatePropagation()
}else{a.propagationStopped=true
}a.stopPropagation();
a.preventDefault();
return false
}return true
};
FastClick.prototype.onClick=function(a){var b;
if(this.trackingClick){this.targetElement=null;
this.trackingClick=false;
return true
}if(a.target.type==="submit"&&a.detail===0){return true
}b=this.onMouse(a);
if(!b){this.targetElement=null
}return b
};
FastClick.prototype.destroy=function(){var a=this.layer;
if(this.deviceIsAndroid){a.removeEventListener("mouseover",this.onMouse,true);
a.removeEventListener("mousedown",this.onMouse,true);
a.removeEventListener("mouseup",this.onMouse,true)
}a.removeEventListener("click",this.onClick,true);
a.removeEventListener("touchstart",this.onTouchStart,false);
a.removeEventListener("touchmove",this.onTouchMove,false);
a.removeEventListener("touchend",this.onTouchEnd,false);
a.removeEventListener("touchcancel",this.onTouchCancel,false)
};
FastClick.notNeeded=function(b){var a;
if(typeof window.ontouchstart==="undefined"){return true
}if((/Chrome\/[0-9]+/).test(navigator.userAgent)){if(FastClick.prototype.deviceIsAndroid){a=document.querySelector("meta[name=viewport]");
if(a&&a.content.indexOf("user-scalable=no")!==-1){return true
}}else{return true
}}if(b.style.msTouchAction==="none"){return true
}return false
};
FastClick.attach=function(a){return new FastClick(a)
};
if(typeof define!=="undefined"&&define.amd){define(function(){return FastClick
})
}else{if(typeof module!=="undefined"&&module.exports){module.exports=FastClick.attach;
module.exports.FastClick=FastClick
}else{window.FastClick=FastClick
}};