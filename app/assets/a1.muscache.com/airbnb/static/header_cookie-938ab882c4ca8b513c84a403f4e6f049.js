!function(b,a){var c=b.Airbnb||{};
function d(g){var f=new RegExp("("+g+")=([^;]*)").exec(a.cookie);
if(!f){return""
}return decodeURIComponent(f[2]).replace(/\+/g," ")
}c.initUserAttributes=function(){var i,l,g=b.userAttributeCookies.flags,j=b.userAttributeCookies.roles,h=b.userAttributeCookies.cookie_name;
try{c.userAttributes=i=JSON.parse(d(h))||{}
}catch(k){c.userAttributes=i={}
}function f(n,o){var m;
o=d(o);
m=o===""?0:parseInt(o,10);
for(var p in n){if(n.hasOwnProperty(p)){i[p]=(n[p]&o)!==0
}}}f(g,b.userAttributeCookies.flags_name);
f(j,b.userAttributeCookies.roles_name);
e()
};
function e(){var j=a.getElementById("csrf-token-meta-tag"),f=d("_csrf_token");
if(j!=null){j.setAttribute("content",f)
}else{var g=a.createElement("meta");
g.name="csrf-token";
g.id="csrf-token-meta-tag";
g.content=f;
a.getElementsByTagName("head")[0].appendChild(g);
var i=a.getElementById("csrf-param-meta-tag");
if(i==null){var h=a.createElement("meta");
h.name="csrf-param";
h.id="csrf-param-meta-tag";
h.content="authenticity_token";
a.getElementsByTagName("head")[0].appendChild(h)
}}}c.initUserAttributes();
b.Airbnb=c
}(window,document);
/*!
 * JS Cookie Plugin
 * https://github.com/carhartl/jquery-cookie
 *
 * Copyright 2011, Klaus Hartl
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.opensource.org/licenses/GPL-2.0
 */
!function(b,a){b.JSCookie={cookie:function(k,j,p){if(arguments.length>1&&(!/Object/.test(Object.prototype.toString.call(j))||j===null||j===undefined)){p=JSON.parse(JSON.stringify(p||{}));
if(j===null||j===undefined){p.expires=-1
}if(typeof p.expires==="number"){var m=p.expires,o=p.expires=new Date();
o.setDate(o.getDate()+m)
}j=String(j);
return(a.cookie=[encodeURIComponent(k),"=",p.raw?j:encodeURIComponent(j),p.expires?"; expires="+p.expires.toUTCString():"",p.path?"; path="+p.path:"",p.domain?"; domain="+p.domain:"",p.secure?"; secure":""].join(""))
}p=j||{};
var c=p.raw?function(i){return i
}:decodeURIComponent;
var h=p.raw?function(i){return i
}:encodeURIComponent;
var n=a.cookie?a.cookie.split("; "):[];
for(var g=0,e=n.length;
g<e;
g++){var f=n[g].split("="),d=c(f[0]);
if(k&&k===d){return c(f[1]||"")
}}return null
}}
}(window,document);
!function(c,a){var b=function(d){if(typeof d==="string"){return new b.fn.init(a.querySelectorAll(d))
}return new b.fn.init(d)
};
b.fn=b.prototype={constructor:b,init:function(d){if(!d){this._el=[]
}else{this._el=d instanceof NodeList||(typeof StaticNodeList!="undefined"&&d instanceof StaticNodeList)?d:[d]
}return this
},each:function(e){var g;
for(var d=0,f=this._el.length;
d<f;
d++){if(this._el[d] instanceof NodeList){this.each(this._el[d],e)
}else{e(d,this._el[d])
}}return this
},show:function(){return this.each(function(d,e){e.style.display="block"
})
},hide:function(){return this.each(function(d,e){e.style.display="none"
})
},addClass:function(d){return this.each(function(f,g){var e=g.className.split(/\s+/);
e.push(d);
g.className=e.join(" ")
})
},text:function(d){return this.each(function(e,f){f.innerText=d
})
}};
b.fn.init.prototype=b.fn;
c.J=b
}(window,document);
!function(a){var b=function(){var c=this;
this.el=document.getElementById("header");
this.userAttributes=Airbnb.userAttributes;
this.personalize()
};
b.prototype.personalize=function(){if(Airbnb.userAttributes.name){J(this.el).addClass("logged_in")
}if(Airbnb.userAttributes){var c=Airbnb.userAttributes;
if(c.name){this.name(Airbnb.userAttributes.name)
}if(c.curr){this.curr(Airbnb.userAttributes.curr)
}if(c.num_h){this.hosting_count(Airbnb.userAttributes.num_h)
}if(c.num_msg){this.unread_message_count(Airbnb.userAttributes.num_msg)
}}};
b.prototype.name=function(c){J(this.el.querySelectorAll(".value_name")).text(c)
};
b.prototype.curr=function(c){J(this.el.querySelectorAll(".value_currency")).text(c);
J(document.getElementById("currency_header_icon")).addClass(c)
};
b.prototype.hosting_count=function(e){e=parseInt(e,10);
var d=this.el.querySelector(".header-dropdown .listings");
var c=J(d);
if(e===0){c.hide()
}else{if(d&&e===1){J(d.querySelectorAll(".singular")).show();
J(d.querySelectorAll(".plural")).hide()
}}};
b.prototype.unread_message_count=function(c){if(c>0){J(this.el.querySelector(".unread_count, .alert-count")).show().addClass("in").text(c)
}};
a.HeaderPreload=b
}(window);
!function(b){function a(g,q,d,o){var j={eventQueue:[]},p="treatment_unknown",k="not_in_experiment",f="ERF_STUB",i={user:function(){return q.id
},bev:function(){return d.cookie("bev")
}};
function h(r,s){return(((r&65535)*s)+((((r>>>16)*s)&65535)<<16))&4294967295
}function e(w){var r=w.length,x=3432918353,v=461845907,u=0,t=r&~3;
for(var s=0;
s<t;
s+=4){var y=w.charCodeAt(s)|(w.charCodeAt(s+1)<<8)|(w.charCodeAt(s+2)<<16)|(w.charCodeAt(s+3)<<24);
y=h(y,x);
y=(y<<15)|(y>>>17);
y=h(y,v);
u^=y;
u=(u<<13)|(u>>>19);
u=(u*5+3864292196)|0
}y=0;
switch(r%4){case 3:y=w.charCodeAt(t+2)<<16;
case 2:y|=w.charCodeAt(t+1)<<8;
case 1:y|=w.charCodeAt(t);
y=h(y,x);
y=(y<<15)|(y>>>17);
y=h(y,v);
u^=y
}u^=r;
u^=u>>>16;
u=h(u,2246822507);
u^=u>>>13;
u=h(u,3266489909);
u^=u>>>16;
return u>>>0
}function n(r,u,t){var s="experiment: "+r.toLowerCase()+" subject: "+u;
return(e(s)%t)+1
}function m(r,t){var s="in experiment? experiment: "+r.toLowerCase()+" subject: "+t;
return(e(s)%100)+1
}function l(r,s,t){if(!(s in t)){s=p
}j.logTreatment(r,s);
return t[s]()
}function c(r,s){return l(r,p,s)
}j.logTreatment=function(s,r){j.eventQueue.push({experiment:s,treatment:r})
};
j.deliverExperiment=function(u,y){var r=g[u],t=o&&o.getItem("erfOverride"),w,v,B;
if(!(p in y)){throw new Error("treatment_unknown not passed for experiment "+u)
}if(t){B=JSON.parse(t);
if(B&&B[u]&&B[u] in y){return l(u,B[u],y)
}}if(!r){return c(u,y)
}if(f in r){return l(u,r[f],y)
}if(!(r.subject in i)){return c(u,y)
}w=i[r.subject]();
if(!w){return c(u,y)
}if(m(u,w)>r.percent_exposed){return l(u,k,y)
}v=n(u,w,r.buckets);
for(var x=0,s=0;
x<r.treatments.length;
x++){var z=r.treatments[x].name,A=r.treatments[x].buckets||1;
s+=A;
if(v<=s){return l(u,z,y)
}}return c(u,y)
};
return j
}if(b.Airbnb){b.Airbnb.ERF=a(b.ERF_EXPERIMENTS,b.Airbnb.userAttributes,b.JSCookie,b.localStorage)
}else{module.exports=a
}}(this);