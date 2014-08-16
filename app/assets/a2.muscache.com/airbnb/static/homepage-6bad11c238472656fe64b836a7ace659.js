(function(){AIR.HomepageHelper={intervalId:0,time_slideInterval:7000,time_slideTransition:800,time_captionFadeIn:1000,time_captionFadeOut:300,time_searchBarSlide:900,belongAnywhereControlsDisplayed:false,communityContainerDisplayed:false,initHomepageHero:function(){this.cacheEls();
this.initEvents();
this.showSearch();
this.initCalendars();
this.initPrice();
return this.initCustomForms()
},initEvents:function(){var a=this;
$(".input-wrapper span").live("click",function(b){return a.clickInput(b)
});
$(".search-option").live("focus",function(b){return a.play(a.slideshows.main)
});
$("#location").live("keyup",function(b){return a.play(a.slideshows.main)
});
$("#search_form").live("submit",function(b){return a.checkInputsAndSubmit(b)
});
$(".slideshow-scroll").live("click",function(b){return a.clickSlideArrow(b)
});
$("#belong-anywhere-play-button").live("click",function(b){return a.goFullScreen(b)
});
$("#close-fullscreen").live("click",function(b){return a.goWindowed(b)
});
this.initScrollEvents();
return this.initTitleAnimation()
},cacheEls:function(){this.els={};
this.els.hero=$("#hero");
this.els.arrows=$(".slideshow-scroll");
this.els.loc=$("#location");
this.els.slideshow=$("#slideshow");
this.els.slides=this.els.slideshow.children();
this.els.searchArea=$(".search-area");
this.els.form=$("#search_form");
this.els.video=$("#pretzel-video");
this.els.belongAnywhereSlideshow=$("#belong-anywhere-slideshow");
this.els.belongAnywhereSlides=this.els.belongAnywhereSlideshow.children();
this.els.belongAnywhereSlideshowPrev=$("#belong-anywhere-container .slideshow-scroll-prev");
this.els.belongAnywhereSlideshowNext=$("#belong-anywhere-container .slideshow-scroll-next");
this.els.belongAnywhereSlideshowPlay=$("#belong-anywhere-play-button");
this.els.communityContainer=$(".community-container");
this.els.communityCards=this.els.communityContainer.children();
this.els.communityTravelingCardBackground=$(".background-traveling-card-lazy");
this.els.communityHostingCardBackground=$(".background-hosting-card-lazy");
this.els.communityShareCardBackground=$(".background-share-card-lazy");
this.els.discoverTitle=$(".adventure-title");
return this.els.discoverSection=$(".discovery-tiles")
},initCustomForms:function(){var a,c,b;
a=this.els.form.find("#guests");
c=a.parent().find(".current");
b=function(d){return c.text(a.find(":selected").text())
};
a.change(b);
a.keyup(b);
a.focus(function(){return c.addClass("focus")
});
a.blur(function(){return c.removeClass("focus")
});
return a.change()
},initShowMoreDiscovery:function(a){var b=this;
$(".discover-destination-image").click(function(){return Tracking.queueEvent({event_name:"discovery",event_data:{page:"p1",operation:"click",types:a.types.slice(0,8),metadata:a.metadata.slice(0,8),locations:a.locations.slice(0,8),titles:a.titles.slice(0,8),user_location:a.user_location,user_locale:a.user_locale,user_tld:a.user_tld,click_index:a.locations.indexOf($(this).data("id"))}})
});
return $(".show-more").on("click",function(c){c.preventDefault();
$(".show-more").attr("disabled","disabled");
$(".discover-destination-image").off("click");
$(".show-more-section").eq(0).replaceWith(a.second_page_discovery_html);
$(".show-more").addClass("hide");
$(".all-destinations").removeClass("hide");
$(".discover-destination-image").click(function(){return Tracking.queueEvent({event_name:"discovery",event_data:{page:"p1",operation:"click",types:a.types,metadata:a.metadata,locations:a.locations,titles:a.titles,user_location:a.user_location,user_locale:a.user_locale,user_tld:a.user_tld,city_index:a.locations.indexOf($(this).data("id"))}})
});
return Airbnb.Tracking.logEvent({event_name:"discovery",event_data:{page:"p1",operation:"impression",types:a.types,metadata:a.metadata,locations:a.locations,titles:a.titles,user_location:a.user_location,user_locale:a.user_locale,user_tld:a.user_tld}})
})
},loadP1Discovery:function(b){var a,c;
c=$.parseJSON(b);
a=$(".homepage-module");
if(c.error!=null){a.eq(0).remove();
$(".discovery-tiles").remove();
return
}a.eq(0).replaceWith(c.first_page_discovery_html);
return this.initShowMoreDiscovery(c)
},initPrice:function(){var a,b=this;
a=Airbnb.userAttributes.guest_exchange;
if(a){return this.els.slides.each(function(f,h){var c,d,g;
c=$(h).find(".price");
g=c.data("price");
d=I18n.guestConvertFromUsd(g,{format:true});
return c.html(d)
})
}},clickInput:function(a){return $(a.currentTarget).prev("input[type='text']").focus()
},initCalendars:function(){var b,c,a,g,d;
a=$.datepicker._defaults.dateFormat;
b=$("#checkin");
c=$("#checkout");
g=b.attr("placeholder")?"":a;
try{$.datepicker.parseDate(b.val());
$.datepicker.parseDate(c.val())
}catch(f){d=f;
b.val(g).blur();
c.val(g).blur()
}return this.els.form.airbnbInputDateSpan()
},initTitleAnimation:function(){var a,b=this;
a=$(window);
return this.titleAnimator=setInterval(function(){var f,c,e,d;
f=a.scrollTop()-200;
if(f>0&&f<100){e=100-f;
c=f-100;
d=f/100;
b.els.discoverTitle.css("transform","translate3d(0, "+e+"px, 0)");
b.els.discoverTitle.css("opacity",d.toString());
return b.els.discoverSection.css("transform","translate3d(0, "+c+"px, 0)")
}else{if(f>100){clearInterval(b.titleAnimator);
b.els.discoverTitle.css("transform","translate3d(0, 0, 0)");
b.els.discoverTitle.css("opacity","1");
return b.els.discoverSection.css("transform","translate3d(0, 0, 0)")
}}},16)
},showSearch:function(){return this.els.searchArea.find("input[type='text']").placeholder()
},checkInputsAndSubmit:function(b){var a;
a=$("#enter_location_error_message");
if(this.locationIsBlank()){a.removeClass("hide");
return false
}a.addClass("hide");
b.preventDefault();
return Airbnb.SearchUtils.handleFormSubmit(b.currentTarget)
},locationIsBlank:function(){return !this.els.loc.val()||this.els.loc.hasClass("placeholder")||this.els.loc.hasClass("pac-placeholder")
},initScrollEvents:function(){var a=this;
return setInterval(function(){var c,b,d;
d=$(window).scrollTop();
b=$(window).scrollTop()+$(window).height();
a.belongAnywhereControlsDisplayed=false;
if(a.els.belongAnywhereSlideshow.length){c=a.els.belongAnywhereSlideshow.offset().top+a.els.belongAnywhereSlideshow.height();
if(!a.belongAnywhereControlsDisplayed&&b>=c-80){a.belongAnywhereControlsDisplayed=true;
a.els.belongAnywhereSlideshowPrev.removeClass("hidden");
a.els.belongAnywhereSlideshowNext.removeClass("hidden");
a.els.belongAnywhereSlideshowPlay.removeClass("hidden")
}}if(a.els.communityContainer.length){if(!a.communityContainerDisplayed&&b>=a.els.communityContainer.position().top){a.communityContainerDisplayed=true;
a.els.communityTravelingCardBackground.addClass("background-traveling-card");
a.els.communityHostingCardBackground.addClass("background-hosting-card");
a.els.communityShareCardBackground.addClass("background-share-card");
return a.els.communityCards.removeClass("hidden")
}}},500)
},initSlideshows:function(){this.startingSlides=true;
this.slideshows={};
this.slideshows.main={};
this.slideshows.main.slides=this.els.slides;
this.slideshows.main.currentSlideIndex=0;
this.slideshows.main.video=this.els.video;
this.slideshows.main.animating=false;
this.slideshows.belongAnywhere={};
this.slideshows.belongAnywhere.slides=this.els.belongAnywhereSlides;
this.slideshows.belongAnywhere.currentSlideIndex=0;
return this.slideshows.belongAnywhere.animating=false
},initHeroSlideshow:function(){var b,a=this;
this.els.slides.find("img[data-image-url]").each(function(d,e){var c;
c=$(e);
return c.attr("src",c.data("image-url"))
});
b=this.els.slideshow.imagesLoaded();
return b.done(function(c){var d;
d=$(".slideshow-scroll");
d.removeClass("faded-out");
a.els.hero.hover(function(){return d.removeClass("faded-out")
},function(){return d.addClass("faded-out")
});
return a.play(a.slideshows.main)
})
},play:function(a){var b=this;
this.pause;
return this.intervalId=setInterval(function(){return b.next(a)
},this.time_slideInterval)
},pause:function(){return clearInterval(this.intervalId)
},next:function(a){var b,c;
if(a.animating){return
}b=a.slides.eq(a.currentSlideIndex);
a.currentSlideIndex++;
a.currentSlideIndex%=a.slides.length;
c=a.slides.eq(a.currentSlideIndex);
if(this.startingSlides&&a.currentSlideIndex===1&&a.video&&!a.video.hasClass("video-playing")){this.els.video.find("source").attr("src","");
this.startingSlides=false
}return this.transitionSlide(b,c,a,"left")
},prev:function(a){var b,c;
if(a.animating){return
}b=a.slides.eq(a.currentSlideIndex);
a.currentSlideIndex--;
a.currentSlideIndex+=a.slides.length;
a.currentSlideIndex%=a.slides.length;
c=a.slides.eq(a.currentSlideIndex);
return this.transitionSlide(b,c,a,"right")
},clickSlideArrow:function(a){a.preventDefault();
if(a.target.id==="belong-anywhere-container"||$(a.target).parents("#belong-anywhere-container").size()){if($(a.currentTarget).hasClass("slideshow-scroll-prev")){return this.prev(this.slideshows.belongAnywhere)
}else{return this.next(this.slideshows.belongAnywhere)
}}else{if($(a.currentTarget).hasClass("slideshow-scroll-prev")){this.prev(this.slideshows.main)
}else{this.next(this.slideshows.main)
}return this.play(this.slideshows.main)
}},transitionSlide:function(b,d,a,c){var e=this;
a.animating=true;
d.addClass("next "+c);
b.find(".caption").fadeOut(this.time_captionFadeOut);
return b.fadeOut(this.time_slideTransition,function(){b.removeClass("active");
d.addClass("active").removeClass("next "+c);
b.show();
d.find(".caption").fadeIn(e.time_captionFadeIn);
return a.animating=false
})
},initVideoPlayer:function(a){this.video=$("#belong-anywhere-video")[0];
this.playButton=$("#play-button");
this.player=$("#fullscreen-video-player");
this.fadeTimeout=null;
this.hovering=false;
this.videoLoaded=false;
return this.fullScreen=false
},goFullScreen:function(a){var b=this;
$("#belong-anywhere-play-button").off("click");
if(!this.fullScreen){this.fullScreen=true;
this.player.removeClass("hidden");
if(this.video.paused){this.toggleVideoPlay()
}this.player.css({"z-index":1001});
this.player.on("transitionend webkitTransitionEnd",function(c){$("body").addClass("fullscreen-mode");
return b.player.off("transitionend webkitTransitionEnd")
});
this.video.onended=function(c){b.goWindowed();
return b.next(b.slideshows.belongAnywhere)
};
$(document).on("keyup",function(c){if(c.keyCode===27){b.goWindowed()
}if(c.keyCode===32){return b.toggleVideoPlay()
}});
this.playButton.on("click",function(c){return b.toggleVideoPlay()
});
$("#belong-anywhere-video").on("click",function(c){return b.toggleVideoPlay()
});
this.fullScreenPosition=$(window).scrollTop();
return setTimeout((function(){return b.videoLoaded=true
}),1000)
}},goWindowed:function(){var a=this;
if(this.fullScreen){this.player.addClass("hidden");
this.player.on("transitionend webkitTransitionEnd",function(b){$("body").removeClass("fullscreen-mode");
window.scrollTo(0,a.fullScreenPosition);
if(!a.video.paused){a.toggleVideoPlay()
}a.player.css({"z-index":-1001});
a.player.off("transitionend webkitTransitionEnd");
a.fullScreen=false;
return $("#belong-anywhere-play-button").live("click",function(c){return a.goFullScreen(c)
})
});
$(document).off("keyup");
this.playButton.off("click");
return $("#belong-anywhere-video").off("click")
}},toggleVideoPlay:function(){if(this.video.paused){this.video.play();
return this.playButton.addClass("hide")
}else{this.video.pause();
return this.playButton.removeClass("hide")
}}}
}).call(this);
(function(d,b){var a="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";
d.fn.imagesLoaded=function(n){function k(){var e=d(r),f=d(s);
v&&(s.length?v.reject(u,e,f):v.resolve(u));
d.isFunction(n)&&n.call(t,u,e,f)
}function q(e,f){e.src===a||-1!==d.inArray(e,p)||(p.push(e),f?s.push(e):r.push(e),d.data(e,"imagesLoaded",{isBroken:f,src:e.src}),c&&v.notifyWith(d(e),[f,u,d(r),d(s)]),u.length===p.length&&(setTimeout(k),u.unbind(".imagesLoaded")))
}var t=this,v=d.isFunction(d.Deferred)?d.Deferred():0,c=d.isFunction(v.notify),u=t.find("img").add(t.filter("img")),p=[],r=[],s=[];
u.length?u.bind("load.imagesLoaded error.imagesLoaded",function(e){q(e.target,"error"===e.type)
}).each(function(f,g){var h=g.src,i=d.data(g,"imagesLoaded");
if(i&&i.src===h){q(g,i.isBroken)
}else{if(g.complete&&g.naturalWidth!==b){q(g,0===g.naturalWidth||0===g.naturalHeight)
}else{if(g.readyState||g.complete){g.src=a,g.src=h
}}}}):k();
return v?v.promise(t):t
}
})(jQuery);
!function(b){function a(f,e,c,g){function d(i,h){g.logEvent({event_name:"experiment_assignment",event_data:{experiment:i,treatment:h,user_id:e.id||null,bev:c.cookie("bev")}})
}f.logTreatment=function(i,h){d(i,h)
};
if(f.eventQueue.length){f.eventQueue.forEach(function(h){d(h.experiment,h.treatment)
});
f.eventQueue=[]
}return f
}if(b.Airbnb&&b.Airbnb.ERF){b.Airbnb.ERF=a(b.Airbnb.ERF,b.Airbnb.userAttributes,b.JSCookie,Airbnb.Tracking)
}else{module.exports=a
}}(this);