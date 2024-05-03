<script setup>
import { usePage, Link } from "@inertiajs/vue3";
import { onMounted, ref } from "vue";
import { useInstitucion } from "@/composables/institucion/useInstitucion";
import { useMenuPortalStore } from "@/stores/menuPortalStore";
const menu_portal_store = useMenuPortalStore();
const { oInstitucion } = useInstitucion();
const { props } = usePage();
const user = props.auth.user;
var url_assets = "";
var url_principal = "";

const listMenu = ref([
    {
        label: "Inicio",
        url: route("portal.inicio"),
        ruta: "portal.inicio",
    },
]);

const cambiarRuta = (ruta) => {
    menu_portal_store.setLoadingPage(true);
    menu_portal_store.setRutaActual(ruta);
};

onMounted(() => {
    url_assets = props.url_assets;
    url_principal = props.url_principal;

    $(document).ready(function () {
        // loading
        $("#ct-loadding").fadeOut("slow", function () {
            $(this).remove();
        });

        // progress path
        var progressPath = document.querySelector(".progress-wrap path");
        var pathLength = progressPath.getTotalLength();
        progressPath.style.transition = progressPath.style.WebkitTransition =
            "none";
        progressPath.style.strokeDasharray = pathLength + " " + pathLength;
        progressPath.style.strokeDashoffset = pathLength;
        progressPath.getBoundingClientRect();
        progressPath.style.transition = progressPath.style.WebkitTransition =
            "stroke-dashoffset 10ms linear";
        var updateProgress = function () {
            var scroll = $(window).scrollTop();
            var height = $(document).height() - $(window).height();
            var progress = pathLength - (scroll * pathLength) / height;
            progressPath.style.strokeDashoffset = progress;
        };
        updateProgress();
        $(window).scroll(updateProgress);
        var offset = 50;
        var duration = 550;
        jQuery(window).on("scroll", function () {
            if (jQuery(this).scrollTop() > offset) {
                jQuery(".progress-wrap").addClass("active-progress");
            } else {
                jQuery(".progress-wrap").removeClass("active-progress");
            }
        });
        jQuery(".progress-wrap").on("click", function (event) {
            event.preventDefault();
            jQuery("html, body").animate({ scrollTop: 0 }, duration);
            return false;
        });
    });
});
</script>
<template>
    <!-- preloader start -->
    <div id="ct-loadding" class="ct-loader style3">
        <div class="loading-spin"></div>
    </div>
    <div class="progress-wrap style5 active-progress">
        <svg
            class="progress-circle svg-content"
            width="100%"
            height="100%"
            viewBox="-1 -1 102 102"
        >
            <path
                d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98"
                style="
                    transition: stroke-dashoffset 10ms linear 0s;
                    stroke-dasharray: 307.919, 307.919;
                    stroke-dashoffset: 231.676;
                "
            ></path>
        </svg>
    </div>
    <!-- preloader end -->

    <!-- Main Header -->
    <header class="header-style-six">
        <!-- Header Top -->
        <div class="header-top">
            <div class="container">
                <div class="inner-container">
                    <div
                        class="d-flex justify-content-between align-items-center flex-wrap"
                    >
                        <!-- Header Location -->
                        <div class="location">
                            {{ oInstitucion.dir }}
                        </div>

                        <!-- Social Box -->
                        <ul class="header-top_socials">
                            <li>
                                <a
                                    :href="oInstitucion.facebook"
                                    class="fab fa-facebook-f"
                                    target="_blank"
                                ></a>
                            </li>
                            <li>
                                <a
                                    :href="oInstitucion.youtube"
                                    class="fab fa-youtube"
                                    target="_blank"
                                ></a>
                            </li>
                            <li>
                                <a
                                    :href="oInstitucion.twitter"
                                    class="fab fa-twitter"
                                    target="_blank"
                                ></a>
                            </li>

                            <!-- <li>
                                <a
                                    :href="oInstitucion.facebook"
                                    class="fab fa-instagram"
                                    target="_blank"
                                ></a>
                            </li> -->
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <nav class="navbar">
            <div class="institucion">
                {{ oInstitucion.nombre }}
            </div>
            <ul class="menu">
                <li v-if="user">
                    <a href="/inicio"
                        ><i class="fa fa-user"></i> {{ user.full_name }}</a
                    >
                </li>
                <li v-else>
                    <a href="/login"><i class="fa fa-sign-in"></i> Acceder</a>
                </li>
            </ul>
        </nav>
    </header>
    <!-- End Main Header -->
</template>
