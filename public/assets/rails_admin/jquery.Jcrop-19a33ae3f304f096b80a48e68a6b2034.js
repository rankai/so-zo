!function(e){e.Jcrop=function(t,n){function o(e){return Math.round(e)+"px"}function r(e){return J.baseClass+"-"+e}function i(){return e.fx.step.hasOwnProperty("backgroundColor")}function a(t){var n=e(t).offset();return[n.left,n.top]}function s(e){return[e.pageX-P[0],e.pageY-P[1]]}function c(t){"object"!=typeof t&&(t={}),J=e.extend(J,t),e.each(["onChange","onSelect","onRelease","onDblClick"],function(e,t){"function"!=typeof J[t]&&(J[t]=function(){})})}function u(e,t,n){if(P=a(q),pt.setCursor("move"===e?e:e+"-resize"),"move"===e)return pt.activateHandlers(l(t),b,n);var o=lt.getFixed(),r=h(e),i=lt.getCorner(h(r));lt.setPressed(lt.getCorner(r)),lt.setCurrent(i),pt.activateHandlers(d(e,o),b,n)}function d(e,t){return function(n){if(J.aspectRatio)switch(e){case"e":n[1]=t.y+1;break;case"w":n[1]=t.y+1;break;case"n":n[0]=t.x+1;break;case"s":n[0]=t.x+1}else switch(e){case"e":n[1]=t.y2;break;case"w":n[1]=t.y2;break;case"n":n[0]=t.x2;break;case"s":n[0]=t.x2}lt.setCurrent(n),ft.update()}}function l(e){var t=e;return gt.watchKeys(),function(e){lt.moveOffset([e[0]-t[0],e[1]-t[1]]),t=e,ft.update()}}function h(e){switch(e){case"n":return"sw";case"s":return"nw";case"e":return"nw";case"w":return"ne";case"ne":return"sw";case"nw":return"se";case"se":return"nw";case"sw":return"ne"}}function f(e){return function(t){return J.disabled?!1:"move"!==e||J.allowMove?(P=a(q),ot=!0,u(e,s(t)),t.stopPropagation(),t.preventDefault(),!1):!1}}function p(e,t,n){var o=e.width(),r=e.height();o>t&&t>0&&(o=t,r=t/e.width()*e.height()),r>n&&n>0&&(r=n,o=n/e.height()*e.width()),tt=e.width()/o,nt=e.height()/r,e.width(o).height(r)}function g(e){return{x:e.x*tt,y:e.y*nt,x2:e.x2*tt,y2:e.y2*nt,w:e.w*tt,h:e.h*nt}}function b(){var e=lt.getFixed();e.w>J.minSelect[0]&&e.h>J.minSelect[1]?(ft.enableHandles(),ft.done()):ft.release(),pt.setCursor(J.allowSelect?"crosshair":"default")}function w(e){if(J.disabled)return!1;if(!J.allowSelect)return!1;ot=!0,P=a(q),ft.disableHandles(),pt.setCursor("crosshair");var t=s(e);return lt.setPressed(t),ft.update(),pt.activateHandlers(v,b,"touch"===e.type.substring(0,5)),gt.watchKeys(),e.stopPropagation(),e.preventDefault(),!1}function v(e){lt.setCurrent(e),ft.update()}function y(){var t=e("<div></div>").addClass(r("tracker"));return R&&t.css({opacity:0,backgroundColor:"white"}),t}function m(e){G.removeClass().addClass(r("holder")).addClass(e)}function x(e,t){function n(){window.setTimeout(v,l)}var o=e[0]/tt,r=e[1]/nt,i=e[2]/tt,a=e[3]/nt;if(!rt){var s=lt.flipCoords(o,r,i,a),c=lt.getFixed(),u=[c.x,c.y,c.x2,c.y2],d=u,l=J.animationDelay,h=s[0]-u[0],f=s[1]-u[1],p=s[2]-u[2],g=s[3]-u[3],b=0,w=J.swingSpeed;o=d[0],r=d[1],i=d[2],a=d[3],ft.animMode(!0);var v=function(){return function(){b+=(100-b)/w,d[0]=Math.round(o+b/100*h),d[1]=Math.round(r+b/100*f),d[2]=Math.round(i+b/100*p),d[3]=Math.round(a+b/100*g),b>=99.8&&(b=100),100>b?(S(d),n()):(ft.done(),ft.animMode(!1),"function"==typeof t&&t.call(bt))}}();n()}}function C(e){S([e[0]/tt,e[1]/nt,e[2]/tt,e[3]/nt]),J.onSelect.call(bt,g(lt.getFixed())),ft.enableHandles()}function S(e){lt.setPressed([e[0],e[1]]),lt.setCurrent([e[2],e[3]]),ft.update()}function k(){return g(lt.getFixed())}function z(){return lt.getFixed()}function M(e){c(e),B()}function O(){J.disabled=!0,ft.disableHandles(),ft.setCursor("default"),pt.setCursor("default")}function j(){J.disabled=!1,B()}function F(){ft.done(),pt.activateHandlers(null,null)}function H(){G.remove(),E.show(),E.css("visibility","visible"),e(t).removeData("Jcrop")}function D(e,t){ft.release(),O();var n=new Image;n.onload=function(){var o=n.width,r=n.height,i=J.boxWidth,a=J.boxHeight;q.width(o).height(r),q.attr("src",e),N.attr("src",e),p(q,i,a),L=q.width(),X=q.height(),N.width(L).height(X),st.width(L+2*at).height(X+2*at),G.width(L).height(X),ht.resize(L,X),j(),"function"==typeof t&&t.call(bt)},n.src=e}function I(e,t,n){var o=t||J.bgColor;J.bgFade&&i()&&J.fadeTime&&!n?e.animate({backgroundColor:o},{queue:!1,duration:J.fadeTime}):e.css("backgroundColor",o)}function B(e){J.allowResize?e?ft.enableOnly():ft.enableHandles():ft.disableHandles(),pt.setCursor(J.allowSelect?"crosshair":"default"),ft.setCursor(J.allowMove?"move":"default"),J.hasOwnProperty("trueSize")&&(tt=J.trueSize[0]/L,nt=J.trueSize[1]/X),J.hasOwnProperty("setSelect")&&(C(J.setSelect),ft.done(),delete J.setSelect),ht.refresh(),J.bgColor!=ct&&(I(J.shade?ht.getShades():G,J.shade?J.shadeColor||J.bgColor:J.bgColor),ct=J.bgColor),ut!=J.bgOpacity&&(ut=J.bgOpacity,J.shade?ht.refresh():ft.setBgOpacity(ut)),Z=J.maxSize[0]||0,$=J.maxSize[1]||0,_=J.minSize[0]||0,et=J.minSize[1]||0,J.hasOwnProperty("outerImage")&&(q.attr("src",J.outerImage),delete J.outerImage),ft.refresh()}var P,J=e.extend({},e.Jcrop.defaults),A=navigator.userAgent.toLowerCase(),R=/msie/.test(A),T=/msie [1-6]\./.test(A);"object"!=typeof t&&(t=e(t)[0]),"object"!=typeof n&&(n={}),c(n);var K={border:"none",visibility:"visible",margin:0,padding:0,position:"absolute",top:0,left:0},E=e(t),W=!0;if("IMG"==t.tagName){if(0!=E[0].width&&0!=E[0].height)E.width(E[0].width),E.height(E[0].height);else{var Y=new Image;Y.src=E[0].src,E.width(Y.width),E.height(Y.height)}var q=E.clone().removeAttr("id").css(K).show();q.width(E.width()),q.height(E.height()),E.after(q).hide()}else q=E.css(K).show(),W=!1,null===J.shade&&(J.shade=!0);p(q,J.boxWidth,J.boxHeight);var L=q.width(),X=q.height(),G=e("<div />").width(L).height(X).addClass(r("holder")).css({position:"relative",backgroundColor:J.bgColor}).insertAfter(E).append(q);J.addClass&&G.addClass(J.addClass);var N=e("<div />"),V=e("<div />").width("100%").height("100%").css({zIndex:310,position:"absolute",overflow:"hidden"}),Q=e("<div />").width("100%").height("100%").css("zIndex",320),U=e("<div />").css({position:"absolute",zIndex:600}).dblclick(function(){var e=lt.getFixed();J.onDblClick.call(bt,e)}).insertBefore(q).append(V,Q);W&&(N=e("<img />").attr("src",q.attr("src")).css(K).width(L).height(X),V.append(N)),T&&U.css({overflowY:"hidden"});var Z,$,_,et,tt,nt,ot,rt,it,at=J.boundary,st=y().width(L+2*at).height(X+2*at).css({position:"absolute",top:o(-at),left:o(-at),zIndex:290}).mousedown(w),ct=J.bgColor,ut=J.bgOpacity;P=a(q);var dt=function(){function e(){var e,t={},n=["touchstart","touchmove","touchend"],o=document.createElement("div");try{for(e=0;e<n.length;e++){var r=n[e];r="on"+r;var i=r in o;i||(o.setAttribute(r,"return;"),i="function"==typeof o[r]),t[n[e]]=i}return t.touchstart&&t.touchend&&t.touchmove}catch(a){return!1}}function t(){return J.touchSupport===!0||J.touchSupport===!1?J.touchSupport:e()}return{createDragger:function(e){return function(t){return J.disabled?!1:"move"!==e||J.allowMove?(P=a(q),ot=!0,u(e,s(dt.cfilter(t)),!0),t.stopPropagation(),t.preventDefault(),!1):!1}},newSelection:function(e){return w(dt.cfilter(e))},cfilter:function(e){return e.pageX=e.originalEvent.changedTouches[0].pageX,e.pageY=e.originalEvent.changedTouches[0].pageY,e},isSupported:e,support:t()}}(),lt=function(){function e(e){e=a(e),p=h=e[0],g=f=e[1]}function t(e){e=a(e),d=e[0]-p,l=e[1]-g,p=e[0],g=e[1]}function n(){return[d,l]}function o(e){var t=e[0],n=e[1];0>h+t&&(t-=t+h),0>f+n&&(n-=n+f),g+n>X&&(n+=X-(g+n)),p+t>L&&(t+=L-(p+t)),h+=t,p+=t,f+=n,g+=n}function r(e){var t=i();switch(e){case"ne":return[t.x2,t.y];case"nw":return[t.x,t.y];case"se":return[t.x2,t.y2];case"sw":return[t.x,t.y2]}}function i(){if(!J.aspectRatio)return c();var e,t,n,o,r=J.aspectRatio,i=J.minSize[0]/tt,a=J.maxSize[0]/tt,d=J.maxSize[1]/nt,l=p-h,b=g-f,w=Math.abs(l),v=Math.abs(b),y=w/v;return 0===a&&(a=10*L),0===d&&(d=10*X),r>y?(t=g,n=v*r,e=0>l?h-n:n+h,0>e?(e=0,o=Math.abs((e-h)/r),t=0>b?f-o:o+f):e>L&&(e=L,o=Math.abs((e-h)/r),t=0>b?f-o:o+f)):(e=p,o=w/r,t=0>b?f-o:f+o,0>t?(t=0,n=Math.abs((t-f)*r),e=0>l?h-n:n+h):t>X&&(t=X,n=Math.abs(t-f)*r,e=0>l?h-n:n+h)),e>h?(i>e-h?e=h+i:e-h>a&&(e=h+a),t=t>f?f+(e-h)/r:f-(e-h)/r):h>e&&(i>h-e?e=h-i:h-e>a&&(e=h-a),t=t>f?f+(h-e)/r:f-(h-e)/r),0>e?(h-=e,e=0):e>L&&(h-=e-L,e=L),0>t?(f-=t,t=0):t>X&&(f-=t-X,t=X),u(s(h,f,e,t))}function a(e){return e[0]<0&&(e[0]=0),e[1]<0&&(e[1]=0),e[0]>L&&(e[0]=L),e[1]>X&&(e[1]=X),[Math.round(e[0]),Math.round(e[1])]}function s(e,t,n,o){var r=e,i=n,a=t,s=o;return e>n&&(r=n,i=e),t>o&&(a=o,s=t),[r,a,i,s]}function c(){var e,t=p-h,n=g-f;return Z&&Math.abs(t)>Z&&(p=t>0?h+Z:h-Z),$&&Math.abs(n)>$&&(g=n>0?f+$:f-$),et/nt&&Math.abs(n)<et/nt&&(g=n>0?f+et/nt:f-et/nt),_/tt&&Math.abs(t)<_/tt&&(p=t>0?h+_/tt:h-_/tt),0>h&&(p-=h,h-=h),0>f&&(g-=f,f-=f),0>p&&(h-=p,p-=p),0>g&&(f-=g,g-=g),p>L&&(e=p-L,h-=e,p-=e),g>X&&(e=g-X,f-=e,g-=e),h>L&&(e=h-X,g-=e,f-=e),f>X&&(e=f-X,g-=e,f-=e),u(s(h,f,p,g))}function u(e){return{x:e[0],y:e[1],x2:e[2],y2:e[3],w:e[2]-e[0],h:e[3]-e[1]}}var d,l,h=0,f=0,p=0,g=0;return{flipCoords:s,setPressed:e,setCurrent:t,getOffset:n,moveOffset:o,getCorner:r,getFixed:i}}(),ht=function(){function t(e,t){p.left.css({height:o(t)}),p.right.css({height:o(t)})}function n(){return r(lt.getFixed())}function r(e){p.top.css({left:o(e.x),width:o(e.w),height:o(e.y)}),p.bottom.css({top:o(e.y2),left:o(e.x),width:o(e.w),height:o(X-e.y2)}),p.right.css({left:o(e.x2),width:o(L-e.x2)}),p.left.css({width:o(e.x)})}function i(){return e("<div />").css({position:"absolute",backgroundColor:J.shadeColor||J.bgColor}).appendTo(f)}function a(){h||(h=!0,f.insertBefore(q),n(),ft.setBgOpacity(1,0,1),N.hide(),s(J.shadeColor||J.bgColor,1),ft.isAwake()?u(J.bgOpacity,1):u(1,1))}function s(e,t){I(l(),e,t)}function c(){h&&(f.remove(),N.show(),h=!1,ft.isAwake()?ft.setBgOpacity(J.bgOpacity,1,1):(ft.setBgOpacity(1,1,1),ft.disableHandles()),I(G,0,1))}function u(e,t){h&&(J.bgFade&&!t?f.animate({opacity:1-e},{queue:!1,duration:J.fadeTime}):f.css({opacity:1-e}))}function d(){J.shade?a():c(),ft.isAwake()&&u(J.bgOpacity)}function l(){return f.children()}var h=!1,f=e("<div />").css({position:"absolute",zIndex:240,opacity:0}),p={top:i(),left:i().height(X),right:i().height(X),bottom:i()};return{update:n,updateRaw:r,getShades:l,setBgColor:s,enable:a,disable:c,resize:t,refresh:d,opacity:u}}(),ft=function(){function t(t){var n=e("<div />").css({position:"absolute",opacity:J.borderOpacity}).addClass(r(t));return V.append(n),n}function n(t,n){var o=e("<div />").mousedown(f(t)).css({cursor:t+"-resize",position:"absolute",zIndex:n}).addClass("ord-"+t);return dt.support&&o.bind("touchstart.jcrop",dt.createDragger(t)),Q.append(o),o}function i(e){var t=J.handleSize,o=n(e,O++).css({opacity:J.handleOpacity}).addClass(r("handle"));return t&&o.width(t).height(t),o}function a(e){return n(e,O++).addClass("jcrop-dragbar")}function s(e){var t;for(t=0;t<e.length;t++)H[e[t]]=a(e[t])}function c(e){var n,o;for(o=0;o<e.length;o++){switch(e[o]){case"n":n="hline";break;case"s":n="hline bottom";break;case"e":n="vline right";break;case"w":n="vline"}j[e[o]]=t(n)}}function u(e){var t;for(t=0;t<e.length;t++)F[e[t]]=i(e[t])}function d(e,t){J.shade||N.css({top:o(-t),left:o(-e)}),U.css({top:o(t),left:o(e)})}function l(e,t){U.width(Math.round(e)).height(Math.round(t))}function h(){var e=lt.getFixed();lt.setPressed([e.x,e.y]),lt.setCurrent([e.x2,e.y2]),p()}function p(e){return M?b(e):void 0}function b(e){var t=lt.getFixed();l(t.w,t.h),d(t.x,t.y),J.shade&&ht.updateRaw(t),M||v(),e?J.onSelect.call(bt,g(t)):J.onChange.call(bt,g(t))}function w(e,t,n){(M||t)&&(J.bgFade&&!n?q.animate({opacity:e},{queue:!1,duration:J.fadeTime}):q.css("opacity",e))}function v(){U.show(),J.shade?ht.opacity(ut):w(ut,!0),M=!0}function m(){S(),U.hide(),J.shade?ht.opacity(1):w(1),M=!1,J.onRelease.call(bt)}function x(){D&&Q.show()}function C(){return D=!0,J.allowResize?(Q.show(),!0):void 0}function S(){D=!1,Q.hide()}function k(e){e?(rt=!0,S()):(rt=!1,C())}function z(){k(!1),h()}var M,O=370,j={},F={},H={},D=!1;J.dragEdges&&e.isArray(J.createDragbars)&&s(J.createDragbars),e.isArray(J.createHandles)&&u(J.createHandles),J.drawBorders&&e.isArray(J.createBorders)&&c(J.createBorders),e(document).bind("touchstart.jcrop-ios",function(t){e(t.currentTarget).hasClass("jcrop-tracker")&&t.stopPropagation()});var I=y().mousedown(f("move")).css({cursor:"move",position:"absolute",zIndex:360});return dt.support&&I.bind("touchstart.jcrop",dt.createDragger("move")),V.append(I),S(),{updateVisible:p,update:b,release:m,refresh:h,isAwake:function(){return M},setCursor:function(e){I.css("cursor",e)},enableHandles:C,enableOnly:function(){D=!0},showHandles:x,disableHandles:S,animMode:k,setBgOpacity:w,done:z}}(),pt=function(){function t(t){st.css({zIndex:450}),t?e(document).bind("touchmove.jcrop",a).bind("touchend.jcrop",c):h&&e(document).bind("mousemove.jcrop",o).bind("mouseup.jcrop",r)}function n(){st.css({zIndex:290}),e(document).unbind("touchmove.jcrop"),e(document).unbind("touchend.jcrop"),e(document).unbind("mousemove.jcrop"),e(document).unbind("mouseup.jcrop")}function o(e){return d(s(e)),!1}function r(e){return e.preventDefault(),e.stopPropagation(),ot&&(ot=!1,l(s(e)),ft.isAwake()&&J.onSelect.call(bt,g(lt.getFixed())),n(),d=function(){},l=function(){}),!1}function i(e,n,o){return ot=!0,d=e,l=n,t(o),!1}function a(e){return d(s(dt.cfilter(e))),!1}function c(e){return r(dt.cfilter(e))}function u(e){st.css("cursor",e)}var d=function(){},l=function(){},h=J.trackDocument;return h||st.mousemove(o).mouseup(r).mouseout(r),q.before(st),{activateHandlers:i,setCursor:u}}(),gt=function(){function t(){J.keySupport&&(i.show(),i.focus())}function n(){i.hide()}function o(e,t,n){J.allowMove&&(lt.moveOffset([t,n]),ft.updateVisible(!0)),e.preventDefault(),e.stopPropagation()}function r(e){if(e.ctrlKey||e.metaKey)return!0;it=e.shiftKey?!0:!1;var t=it?10:1;switch(e.keyCode){case 37:o(e,-t,0);break;case 39:o(e,t,0);break;case 38:o(e,0,-t);break;case 40:o(e,0,t);break;case 27:J.allowSelect&&ft.release();break;case 9:return!0}return!1}var i=e('<input type="radio" />').css({position:"fixed",left:"-120px",width:"12px"}).addClass("jcrop-keymgr"),a=e("<div />").css({position:"absolute",overflow:"hidden"}).append(i);return J.keySupport&&(i.keydown(r).blur(n),T||!J.fixedSupport?(i.css({position:"absolute",left:"-20px"}),a.append(i).insertBefore(q)):i.insertBefore(q)),{watchKeys:t}}();dt.support&&st.bind("touchstart.jcrop",dt.newSelection),Q.hide(),B(!0);var bt={setImage:D,animateTo:x,setSelect:C,setOptions:M,tellSelect:k,tellScaled:z,setClass:m,disable:O,enable:j,cancel:F,release:ft.release,destroy:H,focus:gt.watchKeys,getBounds:function(){return[L*tt,X*nt]},getWidgetSize:function(){return[L,X]},getScaleFactor:function(){return[tt,nt]},getOptions:function(){return J},ui:{holder:G,selection:U}};return R&&G.bind("selectstart",function(){return!1}),E.data("Jcrop",bt),bt},e.fn.Jcrop=function(t,n){var o;return this.each(function(){if(e(this).data("Jcrop")){if("api"===t)return e(this).data("Jcrop");e(this).data("Jcrop").setOptions(t)}else"IMG"==this.tagName?e.Jcrop.Loader(this,function(){e(this).css({display:"block",visibility:"hidden"}),o=e.Jcrop(this,t),e.isFunction(n)&&n.call(o)}):(e(this).css({display:"block",visibility:"hidden"}),o=e.Jcrop(this,t),e.isFunction(n)&&n.call(o))}),this},e.Jcrop.Loader=function(t,n,o){function r(){a.complete?(i.unbind(".jcloader"),e.isFunction(n)&&n.call(a)):window.setTimeout(r,50)}var i=e(t),a=i[0];i.bind("load.jcloader",r).bind("error.jcloader",function(){i.unbind(".jcloader"),e.isFunction(o)&&o.call(a)}),a.complete&&e.isFunction(n)&&(i.unbind(".jcloader"),n.call(a))},e.Jcrop.defaults={allowSelect:!0,allowMove:!0,allowResize:!0,trackDocument:!0,baseClass:"jcrop",addClass:null,bgColor:"black",bgOpacity:.6,bgFade:!1,borderOpacity:.4,handleOpacity:.5,handleSize:null,aspectRatio:0,keySupport:!0,createHandles:["n","s","e","w","nw","ne","se","sw"],createDragbars:["n","s","e","w"],createBorders:["n","s","e","w"],drawBorders:!0,dragEdges:!0,fixedSupport:!0,touchSupport:null,shade:null,boxWidth:0,boxHeight:0,boundary:2,fadeTime:400,animationDelay:20,swingSpeed:3,minSelect:[0,0],maxSize:[0,0],minSize:[0,0],onChange:function(){},onSelect:function(){},onDblClick:function(){},onRelease:function(){}}}(jQuery);