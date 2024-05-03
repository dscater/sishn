(function ($) {
	"use strict";

	//=======================
	// header search
	$(".header-search-btn").on("click", function (e) {
		e.preventDefault();
		$(".header-search-form-wrapper").addClass("open");
		$('.header-search-form-wrapper input[type="search"]').focus();
		$('.body-overlay').addClass('active');
	});
	$(".tx-search-close").on("click", function (e) {
		e.preventDefault();
		$(".header-search-form-wrapper").removeClass("open");
		$("body").removeClass("active");
		$('.body-overlay').removeClass('active');
	});
	//=======================
	

	// mobile menu start
	$('#mobile-menu-active').metisMenu();

	$('#mobile-menu-active .dropdown > a').on('click', function (e) {
		e.preventDefault();
	});

	$(".hamburger_menu > a").on("click", function (e) {
		e.preventDefault();
		$(".slide-bar").toggleClass("show");
		$("body").addClass("on-side");
		$('.body-overlay').addClass('active');
		$(this).addClass('active');
	});

	$(".close-mobile-menu > a").on("click", function (e) {
		e.preventDefault();
		$(".slide-bar").removeClass("show");
		$("body").removeClass("on-side");
		$('.body-overlay').removeClass('active');
		$('.hamburger_menu > a').removeClass('active');
	});
	// mobile menu end


	// body overlay
	$('.body-overlay').on('click', function () {
		$(this).removeClass('active');
		$(".slide-bar").removeClass("show");
		$("body").removeClass("on-side");
		$('.hamburger-menu > a').removeClass('active');
		$(".header-search-form-wrapper").removeClass("open");
	});


	// Off Canvas - Start
	// --------------------------------------------------
	$(document).ready(function () {
		$('.cart_close_btn, .body-overlay').on('click', function () {
			$('.cart_sidebar').removeClass('active');
			$('.body-overlay').removeClass('active');
		});

		$('.header-cart-btn').on('click', function () {
			$('.cart_sidebar').addClass('active');
			$('.body-overlay').addClass('active');
		});
	});


	// sidebar info start
	// --------------------------------------------------
	$(document).ready(function () {
		$('.sidebar-menu-close, .body-overlay').on('click', function () {
			$('.offcanvas-sidebar').removeClass('active');
			$('.body-overlay').removeClass('active');
		});

		$('.offcanvas-sidebar-btn').on('click', function () {
			$('.offcanvas-sidebar').addClass('active');
			$('.body-overlay').addClass('active');
		});
	});



	


	//data background
	$("[data-background]").each(function () {
		$(this).css("background-image", "url(" + $(this).attr("data-background") + ") ")
	})

	// data bg color
	$("[data-bg-color]").each(function () {
		$(this).css("background-color", $(this).attr("data-bg-color"));

	});


	// Elements Animation
	if($('.wow').length){
		var wow = new WOW(
		{
			boxClass:     'wow',      // animated element css class (default is wow)
			animateClass: 'animated', // animation css class (default is animated)
			offset:       0,          // distance to the element when triggering the animation (default is 0)
			mobile:       true,       // trigger animations on mobile devices (default is true)
			live:         true       // act on asynchronously loaded content (default is true)
		}
		);
		wow.init();
	}


	var slider = new Swiper('.brand__slide', {
		slidesPerView: 4,
		spaceBetween: 20,
		loop: true,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		speed: 500,
		breakpoints: {
			'1600': {
				slidesPerView: 4,
			},
			'1200': {
				slidesPerView: 4,
			},
			'992': {
				slidesPerView: 4,
			},
			'768': {
				slidesPerView: 3,
			},
			'576': {
				slidesPerView: 2,
			},
			'0': {
				slidesPerView: 2,
			},
		},
	});







	var slider = new Swiper('.brand__slide-two', {
		slidesPerView: 5,
		spaceBetween: 20,
		loop: true,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		speed: 500,
		breakpoints: {
			'1600': {
				slidesPerView: 5,
			},
			'1200': {
				slidesPerView: 5,
			},
			'992': {
				slidesPerView: 4,
			},
			'768': {
				slidesPerView: 3,
			},
			'576': {
				slidesPerView: 2,
			},
			'0': {
				slidesPerView: 2,
			},
		},
	});





	var slider = new Swiper('.services__slide', {
		slidesPerView: 4,
		spaceBetween: 30,
		loop: true,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		navigation: {
			nextEl: ".tx-swiper-arrow-next",
			prevEl: ".tx-swiper-arrow-prev",
		},
		pagination: {
			el: ".swiper-pagination",
			clickable: true,
			type: "progressbar",
		},
		speed: 500,
		breakpoints: {
			'1600': {
				slidesPerView: 3,
			},
			'1200': {
				slidesPerView: 3,
			},
			'992': {
				slidesPerView: 3,
			},
			'768': {
				slidesPerView: 2,
			},
			'576': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});






	var slider = new Swiper('.team__slide', {
		slidesPerView: 3,
		spaceBetween: 30,
		loop: true,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		pagination: {
			el: ".swiper-pagination",
			clickable: true,
		},
		speed: 500,
		breakpoints: {
			'1600': {
				slidesPerView: 3,
			},
			'1200': {
				slidesPerView: 3,
			},
			'992': {
				slidesPerView: 2,
			},
			'768': {
				slidesPerView: 2,
			},
			'576': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});



	var slider = new Swiper('.services__slider', {
		slidesPerView: 3,
		spaceBetween: 30,
		loop: true,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		navigation: {
			nextEl: ".tx-swiper-arrow-next",
			prevEl: ".tx-swiper-arrow-prev",
		},
		pagination: {
			el: ".swiper-pagination",
			clickable: true,
		},
		speed: 500,
		breakpoints: {
			'1600': {
				slidesPerView: 3,
			},
			'1200': {
				slidesPerView: 3,
			},
			'992': {
				slidesPerView: 2,
			},
			'768': {
				slidesPerView: 2,
			},
			'576': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});




	var slider = new Swiper('.services__slider_three', {
		slidesPerView: 4,
		spaceBetween: 0,
		loop: true,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		navigation: {
			nextEl: ".tx-swiper-arrow-next",
			prevEl: ".tx-swiper-arrow-prev",
		},
		pagination: {
			el: ".swiper-pagination",
			clickable: true,
		},
		speed: 500,
		breakpoints: {
			'1600': {
				slidesPerView: 4,
			},
			'1200': {
				slidesPerView: 4,
			},
			'992': {
				slidesPerView: 3,
			},
			'768': {
				slidesPerView: 2,
			},
			'576': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});




	var slider = new Swiper('.main__slider', {
		slidesPerView: 1,
		spaceBetween: 30,
		loop: true,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		pagination: {
			el: ".swiper-pagination",
			clickable: true,
		},
		speed: 500,
		breakpoints: {
			'1600': {
				slidesPerView: 1,
			},
			'1200': {
				slidesPerView: 1,
			},
			'992': {
				slidesPerView: 1,
			},
			'768': {
				slidesPerView: 1,
			},
			'576': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});






	var swiper = new Swiper(".mySwiper", {
		loop: true,
		spaceBetween: 50,
		speed: 500,
		slidesPerView: 3,
		navigation: {
			nextEl: ".service-button-next",
			prevEl: ".service-button-prev",
		},
		breakpoints: {  
			'1400': {
				slidesPerView: 3,
			},
			'1200': {
				slidesPerView: 3,
			},
			'992': {
				slidesPerView: 3,
			},
			'768': {
				slidesPerView: 3,
			},
			'576': {
				slidesPerView: 3,
				spaceBetween: 20,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});
	var swiper2 = new Swiper(".mySwiper2", {
		loop: true,
		spaceBetween: 10,
		effect: 'fade',
		navigation: {
			nextEl: ".service-button-next",
			prevEl: ".service-button-prev",
		},
		thumbs: {
			swiper: swiper,
		},
	});


	// testimonial
	var swiper = new Swiper(".testimonial__nav", {
		loop: true,
		spaceBetween: 20,
		speed: 500,
		slidesPerView: 3,
		direction: "vertical",
		centeredSlides: true,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		breakpoints: {  
			'1400': {
				slidesPerView: 3,
			},
			'1200': {
				slidesPerView: 3,
			},
			'992': {
				slidesPerView: 3,
			},
			'768': {
				slidesPerView: 3,
			},
			'577': {
				slidesPerView: 3,
			},
			'0': {
				slidesPerView: 3,
				direction: "horizontal",
			},
		},
	});
	var swiper2 = new Swiper(".testimonial__active", {
		loop: true,
		spaceBetween: 10,
		effect: 'fade',
		autoplay: {
			enabled: true,
			delay: 6000
		},
		slidesPerView: 1,
		thumbs: {
			swiper: swiper,
		},
	});

	// testimonial two
	var slider = new Swiper('.testimonial__slider', {
		spaceBetween: 0,
		slidesPerView: 3,
		roundLengths: true,
		loop: true,
		loopAdditionalSlides: 30,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		speed: 400,
		breakpoints: {
			'1600': {
				slidesPerView: 3,
			},
			'1200': {
				slidesPerView: 3,
			},
			'992': {
				slidesPerView: 2,
			},
			'768': {
				slidesPerView: 2,
			},
			'576': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});



	var slider = new Swiper('.testimonial__slide_two', {
		slidesPerView: 1,
		spaceBetween: 0,
		loop: true,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		pagination: {
			el: ".swiper-pagination",
			clickable: true,
		},
		speed: 500,
		breakpoints: {
			'1600': {
				slidesPerView: 1,
			},
			'1200': {
				slidesPerView: 1,
			},
			'992': {
				slidesPerView: 1,
			},
			'768': {
				slidesPerView: 1,
			},
			'576': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});




	var slider = new Swiper('.blog__slider', {
		slidesPerView: 3,
		roundLengths: true,
		loop: true,
		loopAdditionalSlides: 30,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		speed: 400,
		navigation: {
			nextEl: ".tx-swiper-arrow-next",
			prevEl: ".tx-swiper-arrow-prev",
		},
		breakpoints: {
			'1600': {
				slidesPerView: 3,
			},
			'1200': {
				slidesPerView: 3,
			},
			'992': {
				slidesPerView: 2,
			},
			'768': {
				slidesPerView: 2,
			},
			'576': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});

	var slider = new Swiper('.service__slider', {
		spaceBetween: 50,
		slidesPerView: 3,
		roundLengths: true,
		loop: true,
		loopAdditionalSlides: 30,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		speed: 400,
		navigation: {
			nextEl: ".service-button-next",
			prevEl: ".service-button-prev",
		},
		breakpoints: {
			'1600': {
				slidesPerView: 3,
			},
			'1200': {
				slidesPerView: 3,
			},
			'992': {
				slidesPerView: 2,
			},
			'768': {
				slidesPerView: 2,
			},
			'576': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});

	// blog slider
	var slider = new Swiper('.blog__active', {
		spaceBetween: 30,
		slidesPerView: 3,
		roundLengths: true,
		loop: true,
		loopAdditionalSlides: 30,
		autoplay: {
			enabled: true,
			delay: 7000
		},
		speed: 600,
		breakpoints: {
			'1600': {
				slidesPerView: 3,
			},
			'1200': {
				slidesPerView: 3,
			},
			'992': {
				slidesPerView: 3,
			},
			'768': {
				slidesPerView: 2,
			},
			'576': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});

	// brand slider
	var slider = new Swiper('.brand__active', {
		spaceBetween: 50,
		slidesPerView: 4,
		roundLengths: true,
		loop: true,
		loopAdditionalSlides: 30,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		speed: 400,
		breakpoints: {
			'1600': {
				slidesPerView: 4,
			},
			'1200': {
				slidesPerView: 4,
			},
			'992': {
				slidesPerView: 4,
			},
			'768': {
				slidesPerView: 3,
			},
			'576': {
				slidesPerView: 2,
			},
			'0': {
				slidesPerView: 2,
			},
		},
	});


	var swiper = new Swiper(".case-study__image", {
		spaceBetween: 25,
		slidesPerView: 3,
		centeredSlides: true,
		roundLengths: true,
		loop: true,
		loopAdditionalSlides: 30,
		speed: 800,
		navigation: {
			nextEl: ".cs-button-next",
			prevEl: ".cs-button-next",
		},
		
		breakpoints: {  
			'1400': {
				slidesPerView: 2,
			},
			'1200': {
				slidesPerView: 2,
			},
			'992': {
				slidesPerView: 1,
				centeredSlides: false,
			},
			'768': {
				slidesPerView: 1,
				centeredSlides: false,
			},
			'576': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});
	var swiper2 = new Swiper(".case-study__content", {
		loop: true,
		effect: 'fade',
		pagination: {
			el: ".swiper-pagination",
			type: "fraction",
		},
		navigation: {
			nextEl: ".cs-button-next",
			prevEl: ".cs-button-prev",
		},
		thumbs: {
			swiper: swiper,
		},
		
	});

	// services slider
	var slider = new Swiper('.tx-service-slider', {
		spaceBetween: 30,
		slidesPerView: 3,
		roundLengths: true,
		loop: true,
		loopAdditionalSlides: 30,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		pagination: {
			el: ".swiper-pagination",
			clickable: true,
		},
		speed: 600,
		breakpoints: {
			'1600': {
				slidesPerView: 3,
			},
			'1200': {
				slidesPerView: 3,
			},
			'992': {
				slidesPerView: 3,
			},
			'768': {
				slidesPerView: 2,
			},
			'576': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});

	// project slider
	var slider = new Swiper('.project-carousel', {
		spaceBetween: 30,
		slidesPerView: 5,
		roundLengths: true,
		loop: true,
		loopAdditionalSlides: 30,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		pagination: {
			el: ".swiper-pagination",
			clickable: true,
			dynamicBullets: true,
		},
		speed: 600,
		breakpoints: {
			'1600': {
				slidesPerView: 5,
			},
			'1200': {
				slidesPerView: 4,
			},
			'992': {
				slidesPerView: 4,
			},
			'768': {
				slidesPerView: 2,
			},
			'576': {
				slidesPerView: 2,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});
	
	// team slider
	var slider = new Swiper('.team__carousel', {
		spaceBetween: 40,
		slidesPerView: 3,
		roundLengths: true,
		loop: true,
		loopAdditionalSlides: 30,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		navigation: {
			nextEl: ".team-button-next",
			prevEl: ".team-button-prev",
		},
		speed: 600,
		breakpoints: {
			'1600': {
				slidesPerView: 3,
			},
			'1200': {
				slidesPerView: 3,
			},
			'992': {
				slidesPerView: 2,
			},
			'768': {
				slidesPerView: 2,
			},
			'576': {
				slidesPerView: 2,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});

	

	if ($(".progress-bar").length) {
		var $progress_bar = $('.progress-bar');
		$progress_bar.appear();
		$(document.body).on('appear', '.progress-bar', function() {
			var current_item = $(this);
			if (!current_item.hasClass('appeared')) {
				var percent = current_item.data('percent');
				current_item.css('width', percent + '%').addClass('appeared').parent().append('<span>' + percent + '%' + '</span>');
			}
			
		});
	};
	
	// banner paralax
	jQuery('.jarallax').jarallax({
		speed: 0.5,
	});

	// Accordion Box start
	if ($(".accordion_box").length) {
		$(".accordion_box").on("click", ".acc-btn", function () {
			var outerBox = $(this).parents(".accordion_box");
			var target = $(this).parents(".accordion");

			if ($(this).next(".acc_body").is(":visible")) {
				$(this).removeClass("active");
				$(this).next(".acc_body").slideUp(300);
				$(outerBox).children(".accordion").removeClass("active-block");
			} else {
				$(outerBox).find(".accordion .acc-btn").removeClass("active");
				$(this).addClass("active");
				$(outerBox).children(".accordion").removeClass("active-block");
				$(outerBox).find(".accordion").children(".acc_body").slideUp(300);
				target.addClass("active-block");
				$(this).next(".acc_body").slideDown(300);
			}
		});
	}
	// Accordion Box end

	// isotop
	$('.grid').imagesLoaded( function() {
		// init Isotope
		var $grid = $('.grid').isotope({
			itemSelector: '.grid-item',
			percentPosition: true,
			masonry: {
			// use outer width of grid-sizer for columnWidth
				columnWidth: '.grid-item',
			}
		});

	// filter items on button click
		$('.portfolio__menu').on( 'click', 'button', function() {
			var filterValue = $(this).attr('data-filter');
			$grid.isotope({ filter: filterValue });
		});
	});

	//for menu active class
	$('.portfolio__menu button').on('click', function(event) {
		$(this).siblings('.active').removeClass('active');
		$(this).addClass('active');
		event.preventDefault();
	});
	
	
	// odometer counter start
	if ($(".odometer").length) {
		$('.odometer').appear();
		$(document.body).on('appear', '.odometer', function(e) {
			var odo = $(".odometer");
			odo.each(function() {
				var countNumber = $(this).attr("data-count");
				$(this).html(countNumber);
			});
			window.odometerOptions = {
				format: 'd',
			};
		});
	}
	// odometer counter end
	
	/* magnificPopup img view */
	$('.popup-image').magnificPopup({
		type: 'image',
		gallery: {
			enabled: true
		}
	});

	/* magnificPopup video view */
	$('.popup-video').magnificPopup({
		type: 'iframe'
	});

	
	$(document).ready(function() {
		var st = $(".tx-split-text");
		if(st.length == 0) return;
		gsap.registerPlugin(SplitText);
		st.each(function(index, el) {
			el.split = new SplitText(el, { 
				type: "lines,words,chars",
				linesClass: "split-line"
			});
			gsap.set(el, { perspective: 400 });

			if( $(el).hasClass('split-in-fade') ){
				gsap.set(el.split.chars, {
					opacity: 0,
					ease: "Back.easeOut",
				});
			}
			if( $(el).hasClass('split-in-right') ){
				gsap.set(el.split.chars, {
					opacity: 0,
					x: "50",
					ease: "Back.easeOut",
				});
			}
			if( $(el).hasClass('split-in-left') ){
				gsap.set(el.split.chars, {
					opacity: 0,
					x: "-50",
					ease: "circ.out",
				});
			}
			if( $(el).hasClass('split-in-up') ){
				gsap.set(el.split.chars, {
					opacity: 0,
					y: "80",
					ease: "circ.out",
				});
			}
			if( $(el).hasClass('split-in-down') ){
				gsap.set(el.split.chars, {
					opacity: 0,
					y: "-80",
					ease: "circ.out",
				});
			}
			if( $(el).hasClass('split-in-rotate') ){
				gsap.set(el.split.chars, {
					opacity: 0,
					rotateX: "50deg",
					ease: "circ.out",
				});
			}
			if( $(el).hasClass('split-in-scale') ){
				gsap.set(el.split.chars, {
					opacity: 0,
					scale: "0.5",
					ease: "circ.out",
				});
			}
			el.anim = gsap.to(el.split.chars, {
				scrollTrigger: {
					trigger: el,
                    // toggleActions: "restart pause resume reverse",
					start: "top 90%",
				},
				x: "0",
				y: "0",
				rotateX: "0",
				scale: 1,
				opacity: 1,
				duration: 0.8, 
				stagger: 0.02,
			});
		});
	});

	//  Countdown
	$('[data-countdown]').each(function () {

		var $this = $(this),
		finalDate = $(this).data('countdown');
		if (!$this.hasClass('countdown-full-format')) {
			$this.countdown(finalDate, function (event) {
				$this.html(event.strftime('<div class="single"><h1>%D</h1><p>Days</p></div> <div class="single"><h1>%H</h1><p>Hours</p></div> <div class="single"><h1>%M</h1><p>Minutes</p></div> <div class="single"><h1>%S</h1><p>Second</p></div>'));
			});
		} else {
			$this.countdown(finalDate, function (event) {
				$this.html(event.strftime('<div class="single"><h1>%Y</h1><p>Years</p></div> <div class="single"><h1>%m</h1><p>Months</p></div> <div class="single"><h1>%W</h1><p>Weeks</p></div> <div class="single"><h1>%d</h1><p>Days</p></div> <div class="single"><h1>%H</h1><p>Hours</p></div> <div class="single"><h1>%M</h1><p>Minutes</p></div> <div class="single"><h1>%S</h1><p>Second</p></div>'));
			});
		}
	});




	/*----------------------------
	= SHOP PRICE SLIDER
    ------------------------------ */
	if($("#slider-range").length) {
		$("#slider-range").slider({
			range: true,
			min: 12,
			max: 200,
			values: [0, 100],
			slide: function(event, ui) {
				$("#amount").val("$" + ui.values[0] + " - $" + ui.values[1]);
			}
		});

		$("#amount").val("$" + $("#slider-range").slider("values", 0) + " - $" + $("#slider-range").slider("values", 1));
	}
	



	/*------------------------------------------
    = TOUCHSPIN FOR PRODUCT SINGLE PAGE
    -------------------------------------------*/
	if ($("input.product-count").length) {
		$("input.product-count").TouchSpin({
			min: 1,
			max: 1000,
			step: 1,
			buttondown_class: "btn btn-link",
			buttonup_class: "btn btn-link",
		});
	}  

	
	$(window).on('load', function(){
		const boxes = gsap.utils.toArray('.tx-animation-style1,.feature-img-animation');
		boxes.forEach(img => {
			gsap.to(img, {
				scrollTrigger: {
					trigger: img,
					start: "top 70%",
					end: "bottom bottom",
					toggleClass: "active",
					once: true,
				}
			});
		});
	});



	jQuery(window).on('scroll', function() {
		if (jQuery(window).scrollTop() > 250) {
			jQuery('.inv-header-section').addClass('sticky-on')
		} else {
			jQuery('.inv-header-section').removeClass('sticky-on')
		}
	});
	jQuery(document).ready(function (o) {
		$('.open_mobile_menu').on("click", function() {
			$('.mobile_menu_wrap').toggleClass("mobile_menu_on");
		});
		$('.open_mobile_menu').on('click', function () {
			$('body').toggleClass('mobile_menu_overlay_on');
		});
		if($('.mobile_menu li.dropdown ul').length){
			$('.mobile_menu li.dropdown').append('<div class="dropdown-btn"><span class="far fa-arrow-right"></span></div>');
			$('.mobile_menu li.dropdown .dropdown-btn').on('click', function() {
				$(this).prev('ul').slideToggle(500);
			});
		}
		$(".dropdown-btn").on("click", function () {
			$(this).toggleClass("toggle-open");
		});
	});

	var swiper = new Swiper(".inv-service-slider", {
		loop: true,
		spaceBetween: 30,
		speed: 500,
		slidesPerView: 3,
		navigation: {
			nextEl: ".inv-service-arrow-next",
			prevEl: ".inv-service-arrow-prev",
		},
		autoplay: {
			enabled: true,
			delay: 6000
		},
		breakpoints: {  
			'1400': {
				slidesPerView: 3,
			},
			'1200': {
				slidesPerView: 3,
			},
			'992': {
				slidesPerView: 2,
			},
			'768': {
				slidesPerView: 2,
			},
			'577': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});



	
	var swiper = new Swiper(".inv-team-slider", {
		loop: true,
		spaceBetween: 50,
		speed: 500,
		slidesPerView: 2,
		navigation: {
			nextEl: ".inv-team-arrow-next",
			prevEl: ".inv-team-arrow-prev",
		},
		autoplay: {
			enabled: true,
			delay: 6000
		},
		breakpoints: {  
			'1400': {
				slidesPerView: 2,
			},
			'1200': {
				slidesPerView: 2,
			},
			'992': {
				slidesPerView: 2,
			},
			'768': {
				slidesPerView: 1,
			},
			'577': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});	
	
	$(document).ready(function () {
		var swiperThumbnails = new Swiper('.inv-testimonial-thumbs', {
			slidesPerView: 4,
			direction: "vertical",

		});
		var swiperGallery = new Swiper('.inv-testimonial-items', {
			spaceBetween: 10,
			simulateTouch: true,
			preloadImages: false,
			loop: true,
			speed: 300,
			thumbs: {
				swiper: swiperThumbnails
			},
		});
	});

	var swiper2 = new Swiper(".inv-slider-area-2", {
		loop: true,
		spaceBetween: 0,
		effect: 'fade',
		speed: 500,
		slidesPerView: 1,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		navigation: {
			nextEl: ".main-slider-button-next",
			prevEl: ".main-slider-button-prev",
		},
	});

	var swiper = new Swiper(".inv-sponsor-slider-2", {
		loop: true,
		spaceBetween: 50,
		speed: 500,
		slidesPerView: 5,
		autoplay: {
			enabled: true,
			delay: 6000
		},
		breakpoints: {  
			'1400': {
				slidesPerView: 5,
			},
			'1200': {
				slidesPerView: 5,
			},
			'992': {
				slidesPerView: 4,
			},
			'768': {
				slidesPerView: 4,
			},
			'577': {
				slidesPerView: 3,
			},
			'0': {
				slidesPerView: 2,
			},
		},
	});	


	var swiper = new Swiper(".inv-portfolio-item-slider", {
		loop: true,
		spaceBetween: 30,
		speed: 500,
		slidesPerView: 3,
		navigation: {
			nextEl: ".inv-portfolio-arrow-next",
			prevEl: ".inv-portfolio-arrow-prev",
		},
		autoplay: {
			enabled: true,
			delay: 6000
		},
		breakpoints: {  
			'1400': {
				slidesPerView: 3,
			},
			'1200': {
				slidesPerView: 3,
			},
			'992': {
				slidesPerView: 2,
			},
			'768': {
				slidesPerView: 2,
			},
			'577': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});


	var swiper = new Swiper(".inv-blog-slider-2", {
		loop: true,
		spaceBetween: 30,
		speed: 500,
		slidesPerView: 2,
		navigation: {
			nextEl: ".inv-blog-arrow-next-2",
			prevEl: ".inv-blog-arrow-prev-2",
		},
		autoplay: {
			enabled: true,
			delay: 6000
		},
		breakpoints: {  
			'1400': {
				slidesPerView: 2,
			},
			'1200': {
				slidesPerView: 2,
			},
			'992': {
				slidesPerView: 2,
			},
			'768': {
				slidesPerView: 1,
			},
			'577': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});
	$('.search-btn').on('click', function() {
		$('.search-body').toggleClass('search-open');
	});
	$(document).on('click', '.accordion-item', function(){
		$(this).addClass('faq_bg').siblings().removeClass('faq_bg')
	});
	$('.zoom-gallery').magnificPopup({
		delegate: 'a',
		type: 'image',
		closeOnContentClick: false,
		closeBtnInside: false,
		mainClass: 'mfp-with-zoom mfp-img-mobile',
		gallery: {
			enabled: true
		},
		zoom: {
			enabled: true,
			duration: 300, 
			opener: function(element) {
				return element.find('img');
			}
		}
	});

	
	
	
})(jQuery);



