<script>
import Inicio from "@/Layouts/Inicio.vue";
import { onMounted } from "vue";
export default {
    layout: Inicio,
};
</script>

<script setup>
import { useInstitucion } from "@/composables/institucion/useInstitucion";
import { useForm, Head } from "@inertiajs/vue3";
import { ref } from "vue";

const { oInstitucion } = useInstitucion();
const url_asset = ref("/");

onMounted(() => {
    url_asset.value = url_assets;
});
</script>

<template>
    <Head title="Inicio" />
    <v-container>
        <v-card class="mb-4">
            <v-card-text class="bg-grey-darken-3">
                <v-row>
                    <v-col
                        cols="12"
                        class="d-flex justify-space-between justify-sm-space-center align-center w-100"
                    >
                        <v-img
                            class="d-none d-sm-flex"
                            :src="oInstitucion.url_logo"
                            style="max-width: 120px"
                        ></v-img>

                        <div class="contenedor_info text-center">
                            <h1 class="text-h4 font-weight-bold text-yellow">
                                {{ oInstitucion.nombre }}
                            </h1>
                            <p>{{ oInstitucion.dir }}</p>
                            <p class="text-caption">
                                {{ oInstitucion.fono1 }}
                                <span v-if="oInstitucion.fono2"
                                    >- {{ oInstitucion.fono2 }}</span
                                >
                            </p>
                        </div>
                        <v-img
                            class="d-none d-sm-flex"
                            :src="oInstitucion.url_logo2"
                            style="max-width: 120px"
                        ></v-img>
                    </v-col>
                </v-row>
            </v-card-text>
        </v-card>
        <v-row>
            <v-col cols="12" md="4">
                <h2
                    class="text-h5 text-center font-weight-bold text-grey-darken-3"
                >
                    Misión
                </h2>
                <v-card
                    variant="flat"
                    color="yellow-lighten-2"
                    class="elevation-2"
                >
                    <v-row>
                        <v-col cols="12" sm="12">
                            <v-card-text>
                                <v-row>
                                    <v-col cols="12">
                                        <p
                                            class="text-caption text-justify text-capitalize text-capitalize"
                                            v-text="oInstitucion.mision"
                                        ></p>
                                    </v-col>
                                </v-row>
                            </v-card-text>
                        </v-col>
                    </v-row>
                </v-card>
            </v-col>
            <v-col cols="12" md="4">
                <h2
                    class="text-h5 text-center font-weight-bold text-grey-darken-3"
                >
                    Objetivo
                </h2>
                <v-card
                    variant="flat"
                    color="yellow-lighten-2"
                    class="elevation-2"
                >
                    <v-row>
                        <v-col cols="12" sm="12">
                            <v-card-text>
                                <v-row>
                                    <v-col cols="12">
                                        <p
                                            class="text-caption text-justify text-capitalize text-capitalize"
                                            v-text="oInstitucion.objetivo"
                                        ></p>
                                    </v-col>
                                </v-row>
                            </v-card-text>
                        </v-col>
                    </v-row>
                </v-card>
            </v-col>
            <v-col cols="12" md="4">
                <h2
                    class="text-h5 text-center font-weight-bold text-grey-darken-3"
                >
                    Historia
                </h2>
                <v-card
                    variant="flat"
                    color="yellow-lighten-2"
                    class="elevation-2"
                >
                    <v-row>
                        <v-col cols="12" sm="12">
                            <v-card-text>
                                <v-row>
                                    <v-col cols="12">
                                        <p
                                            class="text-caption text-justify text-capitalize text-capitalize"
                                            v-text="oInstitucion.historia"
                                        ></p>
                                    </v-col>
                                </v-row>
                            </v-card-text>
                        </v-col>
                    </v-row>
                </v-card>
            </v-col>
            <v-col cols="12" md="6">
                <h2
                    class="text-h5 text-center font-weight-bold text-grey-darken-3"
                >
                    Director y Subdirector
                </h2>
                <v-card
                    variant="flat"
                    color="primary"
                    class="elevation-2"
                >
                    <v-row>
                        <v-col cols="12" sm="12">
                            <v-card-text>
                                <v-row>
                                    <v-col cols="12" md="6" class="text-center">
                                        <v-avatar size="150" color="yellow">
                                            <v-img
                                                v-if="
                                                    oInstitucion.url_foto_director
                                                "
                                                cover
                                                :src="
                                                    oInstitucion.url_foto_director
                                                "
                                            ></v-img>
                                            <span v-else class="">
                                                {{
                                                    oInstitucion.iniciales_director
                                                }}
                                            </span>
                                        </v-avatar>
                                        <p class="text-body-2">
                                            {{ oInstitucion.nombre_director }}
                                        </p>
                                        <p class="text-caption">DIRECTOR</p>
                                    </v-col>
                                    <v-col cols="12" md="6" class="text-center">
                                        <v-avatar size="150" color="yellow">
                                            <v-img
                                                v-if="
                                                    oInstitucion.url_foto_subdirector
                                                "
                                                cover
                                                :src="
                                                    oInstitucion.url_foto_subdirector
                                                "
                                            ></v-img>
                                            <span v-else class="">
                                                {{
                                                    oInstitucion.iniciales_subdirector
                                                }}
                                            </span>
                                        </v-avatar>
                                        <p class="text-body-2">
                                            {{
                                                oInstitucion.nombre_subdirector
                                            }}
                                        </p>
                                        <p class="text-caption">SUBDIRECTOR</p>
                                    </v-col>
                                </v-row>
                            </v-card-text>
                        </v-col>
                    </v-row>
                </v-card>
            </v-col>
            <v-col cols="12" md="6">
                <h2
                    class="text-h5 text-center font-weight-bold text-grey-darken-3"
                >
                    Organigrama
                </h2>
                <v-card
                    class="elevation-5"
                >
                    <v-row>
                        <v-col cols="12" sm="12">
                            <v-card-text>
                                <v-row>
                                    <v-col cols="12">
                                        <v-img
                                            :src="
                                                oInstitucion.url_img_organigrama
                                            "
                                            style="max-width: 100%"
                                        ></v-img>
                                    </v-col>
                                </v-row>
                            </v-card-text>
                        </v-col>
                    </v-row>
                </v-card>
            </v-col>
            <v-col cols="12">
                <h2
                    class="text-h5 text-center font-weight-bold text-grey-darken-3"
                >
                    Ubicación
                </h2>
                <v-card class="elevation-5">
                    <v-row>
                        <v-col cols="12" sm="12">
                            <v-card-text>
                                <v-row>
                                    <v-col
                                        cols="12"
                                        v-html="oInstitucion.ubicacion_google"
                                    >
                                    </v-col>
                                </v-row>
                            </v-card-text>
                        </v-col>
                    </v-row>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<style scoped></style>
