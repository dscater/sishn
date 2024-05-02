<script setup>
import { usePage } from "@inertiajs/vue3";
import { onMounted } from "vue";
const { props } = usePage();
import { useInstitucion } from "@/composables/institucion/useInstitucion";
const { oInstitucion } = useInstitucion();

var url_assets = "";
onMounted(() => {
    url_assets = props.url_assets;
});
</script>
<template>
    <!-- footer start -->
    <footer
        class="site-footer footer-style-four"
        data-background="assets/img/bg/footer-bg.jpg"
    >
        <div class="container">
            <div class="row pb-65 mt-none-30">
                <div class="col-12 mt-30">
                    <div class="footer__widget">
                        <h3 class="widget-title">Contactanos:</h3>
                        <div class="row">
                            <div class="col-md-6">
                                <ul class="footer__info list-unstyled">
                                    <li>
                                        <a href="#!">
                                            <i
                                                class="fas fa-map-marker-alt"
                                            ></i>
                                            <p>{{ oInstitucion.dir }}</p>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#!">
                                            <i class="fas fa-phone"></i>
                                            <p>{{ oInstitucion.fono1 }}</p>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#!">
                                            <i class="fas fa-phone"></i>
                                            <p>{{ oInstitucion.fono2 }}</p>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <ul class="footer__info list-unstyled">
                                    <li>
                                        <a href="#!">
                                            <i class="fas fa-envelope"></i>
                                            <p>{{ oInstitucion.correo1 }}</p>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#!">
                                            <i class="fas fa-envelope"></i>
                                            <p>{{ oInstitucion.correo2 }}</p>
                                        </a>
                                    </li>
                                    <li>
                                        <div class="social-links mt-20">
                                            <a :href="oInstitucion.facebook" target="_blank">
                                                <i
                                                    class="fab fa-facebook-f"
                                                ></i>
                                                <i
                                                    class="fab fa-facebook-f"
                                                ></i>
                                            </a>
                                            <a :href="oInstitucion.youtube" target="_blank">
                                                <i class="fab fa-youtube"></i>
                                                <i class="fab fa-youtube"></i>
                                            </a>
                                            <a :href="oInstitucion.twitter" target="_blank">
                                                <i class="fab fa-twitter"></i>
                                                <i class="fab fa-twitter"></i>
                                            </a>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer__copyright-text text-center">
                © {{ new Date().getFullYear() }} - {{ oInstitucion.nombre }}
            </div>
        </div>
    </footer>
    <!-- footer end -->
</template>
