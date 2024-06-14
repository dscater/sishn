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
        label: "INICIO",
        url: "",
        ruta: "",
        key: "#inicio",
        type: "ancle",
    },
    {
        label: "SOBRE NOSOTROS",
        url: "",
        ruta: "",
        key: "#sobre_nosotros",
        type: "ancle",
    },
    {
        label: "SERVICIOS",
        url: "",
        ruta: "",
        key: "#servicios",
        type: "ancle",
    },
    {
        label: "CONTACTOS",
        url: "",
        ruta: "",
        key: "#contactos",
        type: "ancle",
    },
    {
        label: "WHATSAPP",
        url: "https://wa.me/591" + oInstitucion.value?.fono1,
        ruta: "",
        key: "",
        type: "link",
    },
]);

const cambiarRuta = (ruta) => {
    menu_portal_store.setLoadingPage(true);
    menu_portal_store.setRutaActual(ruta);
};

function toggleMenu() {
    $(".menu_page_movil").toggleClass("show");
}

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

    <div class="menu_page_movil" @click="toggleMenu">
        <div class="contenedor_menu_movil">
            <ul>
                <li v-for="item in listMenu">
                    <template v-if="item.type == 'ancle'">
                        <a @click.stop="toggleMenu" :href="item.key">{{
                            item.label
                        }}</a>
                    </template>
                    <template v-if="item.type == 'link'">
                        <a
                            @click.stop="toggleMenu"
                            :href="item.url"
                            v-if="item.label != 'WHATSAPP'"
                            >{{ item.label }}</a
                        >
                        <a
                            @click.stop="toggleMenu"
                            :href="item.url"
                            target="_blank"
                            class="link_whatsapp"
                            v-else
                            >{{ item.label }}</a
                        >
                    </template>
                </li>
            </ul>
        </div>
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
                <button
                    class="btn btn-default text-white"
                    @click="toggleMenu()"
                >
                    <i class="fa fa-bars"></i>
                </button>
            </div>
            <div class="institucion">
                {{ oInstitucion.nombre }}
            </div>
            <div class="menu_page">
                <ul>
                    <li v-for="item in listMenu">
                        <template v-if="item.type == 'ancle'">
                            <a :href="item.key">{{ item.label }}</a>
                        </template>
                        <template v-if="item.type == 'link'">
                            <a
                                :href="item.url"
                                v-if="item.label != 'WHATSAPP'"
                                >{{ item.label }}</a
                            >
                            <a
                                :href="item.url"
                                target="_blank"
                                class="link_whatsapp"
                                v-else
                                >{{ item.label }}</a
                            >
                        </template>
                    </li>
                </ul>
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
<style>
.menu_page ul li a,
.menu_page_movil ul li a {
    color: white;
}

.menu_page ul {
    gap: 10px 25px;
    display: flex;
}

.menu_page_movil {
    display: none;
    padding-top: 20px;
}

.menu_page_movil ul li {
    display: flex;
    width: 100%;
}

.menu_page_movil ul li a {
    width: 100%;
    padding: 20px 35px;
}

.menu_page ul li a {
    padding: 10px 10px;
}
.link_whatsapp {
    background-color: green;
}
@media (max-width: 869px) {
    .menu_page {
        display: none;
    }

    .menu_page_movil {
        position: fixed;
        height: 100%;
        width: 100%;
        left: 0px;
        z-index: 10000;
        background-color: rgba(0, 0, 0, 0.5);
    }

    .menu_page_movil .contenedor_menu_movil{
        width: 70%;
        height: 100%;
        background-color: rgb(0, 0, 0);
    }

    .menu_page_movil.show {
        display: block;
    }
}
</style>
