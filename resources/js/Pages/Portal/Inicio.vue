<script setup>
import { useApp } from "@/composables/useApp";
import { onMounted, ref, watch } from "vue";
import { useMenuPortalStore } from "@/stores/menuPortalStore";
import { Head, usePage } from "@inertiajs/vue3";
import { useInstitucion } from "@/composables/institucion/useInstitucion";
const { oInstitucion } = useInstitucion();

const menu_portal_store = useMenuPortalStore();
// if (menu_portal_store) {
// menu_portal_store.setLoadingPage(true);
// }
var url_assets = "";
const { props } = usePage();

onMounted(() => {
    // setTimeout(() => {
    //     if (menu_portal_store) {
    //         menu_portal_store.setLoadingPage(false);
    //     }
    // }, 300);

    $(document).ready(function () {
        var slider = new Swiper(".team__slide", {
            slidesPerView: 2,
            spaceBetween: 30,
            // loop: true,
            // autoplay: {
            //     enabled: true,
            //     delay: 6000,
            // },
            // pagination: {
            //     el: ".swiper-pagination",
            //     clickable: true,
            // },
            speed: 500,
            breakpoints: {
                1600: {
                    slidesPerView: 3,
                },
                1200: {
                    slidesPerView: 3,
                },
                992: {
                    slidesPerView: 2,
                },
                768: {
                    slidesPerView: 2,
                },
                576: {
                    slidesPerView: 1,
                },
                0: {
                    slidesPerView: 1,
                },
            },
        });
    });
});
</script>
<template>
    <Head title="Inicio"></Head>

    <!-- Banner One -->
    <section
        class="banner-one"
        :style="
            'background-image: url(' +
            url_assets +
            '/assets/img/slider/img_06.jpg)'
        "
    >
        <span class="banner-one_circle"></span>
        <div
            class="banner-one_shape"
            :style="
                'background-image: url(' +
                url_assets +
                '/assets/img/slider/shape.png)'
            "
        ></div>
        <div
            class="banner-one_pattern"
            :style="
                'background-image: url(assets/' +
                url_assets +
                '/img/slider/pattern-1.png)'
            "
        ></div>
        <div
            class="banner-one_pattern-two"
            :style="
                'background-image: url(assets/' +
                url_assets +
                '/img/slider/pattern-2.png)'
            "
        ></div>
        <div
            class="banner-one_icon"
            :style="
                'background-image: url(' +
                url_assets +
                '/assets/img/slider/circle.png)'
            "
        ></div>
        <div class="container">
            <div class="row clearfix" id="inicio">
                <!-- Banner One Content -->
                <div class="banner-one_content col-lg-6 col-md-12 col-sm-12">
                    <div class="banner-one_content-inner">
                        <!-- <div class="banner-one_title">
                            experience it company
                        </div> -->
                        <h1 class="banner-one_heading">
                            {{ oInstitucion.nombre }}
                        </h1>
                        <div class="banner-one_text">
                            {{ oInstitucion.objetivo }}
                        </div>
                        <!-- Button Box -->
                        <!-- <div class="button-box">
                            <a
                                class="btn-style-two theme-btn"
                                href="contact.html"
                            >
                                <div class="btn-wrap">
                                    <span class="text-one"
                                        >Discover More
                                        <i
                                            class="fas fa-angle-double-right fa-fw"
                                        ></i
                                    ></span>
                                    <span class="text-two"
                                        >Discover More
                                        <i
                                            class="fas fa-angle-double-right fa-fw"
                                        ></i
                                    ></span>
                                </div>
                            </a>
                        </div> -->
                    </div>
                </div>

                <!-- Banner Image Content -->
                <div
                    class="banner-one_image-column col-lg-6 col-md-12 col-sm-12"
                >
                    <div class="banner-one_image-inner">
                        <span class="banner-one_circle-two"></span>
                        <div
                            class="banner-one_icon-two"
                            :style="
                                'background-image: url(' +
                                url_assets +
                                '/assets/img/slider/circle-1.png);'
                            "
                        ></div>
                        <div class="banner-one_image">
                            <img
                                :src="
                                    url_assets +
                                    '/assets/img/slider/image-1.jpg'
                                "
                                alt=""
                            />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Banner One Right Box -->
    </section>
    <!-- End Banner One -->

    <!-- About Us -->
    <section class="about-one">
        <div
            class="about-one_pattern"
            :style="
                'background-image: url(' +
                url_assets +
                '/assets/img/about/pattern-1.png)'
            "
        ></div>
        <div
            class="about-one_pattern-two"
            :style="
                'background-image: url(' +
                url_assets +
                '/assets/img/about/pattern-2.png)'
            "
        ></div>
        <div class="container">
            <div class="row clearfix" id="sobre_nosotros">
                <div class="col-12">
                    <h2 class="w-100 text-center">SOBRE NOSOTROS</h2>
                </div>
                <!-- Content Column -->
                <div class="content-column col-sm-12 col-md-6">
                    <div class="inner-column">
                        <div class="sec-title">
                            <!-- <div class="title">Sobre nuestra empresa</div> -->
                            <h3>Nuestra Misión</h3>
                            <div class="text">
                                {{ oInstitucion.mision }}
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Content Column -->
                <div class="content-column col-sm-12 col-md-6">
                    <div class="inner-column">
                        <div class="sec-title">
                            <!-- <div class="title">Sobre nuestra empresa</div> -->
                            <h3>Nuestra Visión</h3>
                            <div class="text">
                                {{ oInstitucion.vision }}asdas
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End About Us -->
    <section
        class="fluid-one"
        style="background-image: url(assets/img/bg/fluid-bg.jpg)"
    >
        <div class="row clearfix" v-if="oInstitucion.url_img_organigrama">
            <!-- Content Column -->
            <div class="content-column col-lg-7 col-md-12 col-sm-12 mx-auto">
                <div class="inner-column">
                    <div class="sec-title text-center w-100">
                        <h2>Nuestro Organigrama</h2>
                        <img :src="oInstitucion.url_img_organigrama" />
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Case One -->
    <section class="case-one">
        <div
            class="case-one_pattern"
            :style="
                'background-image: url(' +
                url_assets +
                '/assets/img/bg/case-1.png)'
            "
        ></div>
        <div
            class="case-one_pattern-two"
            :style="
                'background-image: url(' +
                url_assets +
                '/assets/img/bg/case-2.png)'
            "
        ></div>
        <div class="container">
            <div class="sec-title">
                <div
                    class="d-flex justify-content-between align-items-center flex-wrap"
                >
                    <div class="left-box">
                        <div class="title">Nuestros representantes</div>
                    </div>
                </div>
            </div>
            <div class="row">
                <!-- Case Block One -->
                <div class="case-block_one masonry-item col-md-4 offset-md-2">
                    <div class="case-block_one-inner">
                        <div class="case-block_one-image">
                            <img :src="oInstitucion.url_foto_director" alt="" />
                            <div class="case-block_one-overlay">
                                <div class="case-block_one-content">
                                    <h5>
                                        <span>{{
                                            oInstitucion.nombre_director
                                        }}</span>
                                    </h5>
                                    <div class="designation">Director</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Case Block One -->
                <div class="case-block_one masonry-item col-md-4">
                    <div class="case-block_one-inner">
                        <div class="case-block_one-image">
                            <img
                                :src="oInstitucion.url_foto_subdirector"
                                alt=""
                            />
                            <div class="case-block_one-overlay">
                                <div class="case-block_one-content">
                                    <h5>
                                        <span>{{
                                            oInstitucion.nombre_subdirector
                                        }}</span>
                                    </h5>
                                    <div class="designation">
                                        Jefe de Mantenimiento
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Case One -->

    <section
        class="fluid-one"
    >
        <div
            class="fluid-one_pattern"
            style="background-image: url(assets/img/bg/pattern-1.png)"
        ></div>
        <div class="outer-container">
            <!-- Fluid One Left -->
            <div class="fluid-one_left">
                <div class="fluid-one_left-inner" id="servicios">
                    <!-- Sec Title -->
                    <div class="sec-title light">
                        <h2>
                            NUESTROS SERVICIOS
                        </h2>
                        <!-- <div class="text">
                            There are many variations of passages of Lorem Ipsum
                            available, but the majority have suffered alteration
                            in some form, by injected humour, or randomised
                            words which don't look.
                        </div> -->
                    </div>
                    <div class="row clearfix">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <ul class="fluid-list">
                                <li>Instalación</li>
                                <li>Capacitación</li>
                            </ul>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <ul class="fluid-list">
                                <li>Mantenimiento Preventivo</li>
                                <li>Mantenimiento Correctivo</li>
                            </ul>
                        </div>
                    </div>
                    <!-- <div class="fluid-progress">
                        <div class="tx-skill-progress-bar">
                            <div class="skill-set-percent headline-2">
                                <h4>Web Development</h4>
                                <div class="progress">
                                    <div
                                        class="progress-bar appeared"
                                        data-percent="95"
                                        style="width: 95%"
                                    ></div>
                                    <span>95%</span>
                                </div>
                            </div>
                            <div class="skill-set-percent headline-2">
                                <h4>Digital Marketing</h4>
                                <div class="progress">
                                    <div
                                        class="progress-bar appeared"
                                        data-percent="80"
                                        style="width: 80%"
                                    ></div>
                                    <span>80%</span>
                                </div>
                            </div>
                            <div class="skill-set-percent headline-2">
                                <h4>Web Design</h4>
                                <div class="progress">
                                    <div
                                        class="progress-bar appeared"
                                        data-percent="65"
                                        style="width: 65%"
                                    ></div>
                                    <span>65%</span>
                                </div>
                            </div>
                        </div>
                    </div> -->
                </div>
            </div>

            <!-- Fluid One Right -->
            <div
                class="fluid-one_right"
                style="background-image: url(assets/img/services/fluid.jpg);background-size: contain;background-repeat: no-repeat;"
            >
            </div>
        </div>
    </section>


    <div v-html="oInstitucion.ubicacion_google" id="contactos" class="col-12 w-100"></div>
</template>

<style>
iframe {
    width: 100% !important;
}
</style>
