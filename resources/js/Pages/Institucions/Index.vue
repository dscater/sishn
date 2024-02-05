<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Institución",
        disabled: false,
        url: route("institucions.index"),
        name_url: "institucions.index",
    },
];
</script>
<script setup>
// componentes
import BreadBrums from "@/Components/BreadBrums.vue";
import { ref, onMounted, reactive } from "vue";
import { useForm } from "@inertiajs/vue3";
import { useInstitucion } from "@/composables/institucion/useInstitucion";
import { useApp } from "@/composables/useApp";
const { setLoading } = useApp();
onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);
});
const props = defineProps({
    institucion: {
        type: Object,
    },
});

const institucion = ref(props.institucion);
const window = ref(0);

const cambiaVentana = (val) => {
    window.value = val;
};

institucion.value["_method"] = "put";

let form = useForm(institucion.value);

const enviaFormulario = () => {
    form.post(route("institucions.update", institucion.value.id), {
        onSuccess: () => {
            setTimeout(() => {
                obtnerInstitucion();
                cambiaVentana(0);
            }, 300);
        },
        onError: (err) => {},
    });
};

const { getInstitucion } = useInstitucion();

const obtnerInstitucion = async () => {
    try {
        institucion.value = await getInstitucion(institucion.id);
        institucion.value["_method"] = "put";
        form = useForm(institucion.value);
        limpiaRefs();
    } catch (error) {
        console.error(error);
    }
};

function cargaArchivo(e, key) {
    form[key] = null;
    form[key] = e.target.files[0];
}

const foto_director = ref(null);
const foto_subdirector = ref(null);
const logo = ref(null);
const img_organigrama = ref(null);

function limpiaRefs() {
    foto_director.value.reset();
    foto_subdirector.value.reset();
    logo.value.reset();
    img_organigrama.value.reset();
}
</script>
<template>
    <v-container>
        <BreadBrums :breadbrums="breadbrums"></BreadBrums>
        <v-row class="mt-0">
            <v-col cols="12" class="d-flex justify-end">
                <v-btn
                    prepend-icon="mdi-pencil"
                    color="yellow-lighten-1"
                    v-if="window == 0"
                    @click="cambiaVentana(1)"
                >
                    Editar</v-btn
                >
                <v-btn
                    prepend-icon="mdi-close"
                    class="mr-2"
                    v-if="window == 1"
                    @click="
                        cambiaVentana(0);
                        obtnerInstitucion();
                    "
                >
                    Cancelar</v-btn
                >
                <v-btn
                    prepend-icon="mdi-content-save"
                    color="yellow-lighten-1"
                    v-if="window == 1"
                    @click="enviaFormulario"
                >
                    Guardar</v-btn
                >
            </v-col>
        </v-row>
        <v-row class="mt-0">
            <v-col cols="12">
                <v-window v-model="window">
                    <v-window-item :key="0">
                        <v-row>
                            <v-col cols="12" sm="12">
                                <v-card>
                                    <v-card-text>
                                        <v-row>
                                            <v-col
                                                cols="12"
                                                sm="4"
                                                md="2"
                                                class="text-center"
                                            >
                                                <v-img
                                                    cover
                                                    v-if="institucion.url_logo"
                                                    :src="institucion.url_logo"
                                                    class="w-75 mx-auto"
                                                ></v-img>
                                                <v-avatar
                                                    v-else
                                                    color="blue"
                                                    size="100"
                                                >
                                                    <span
                                                        class="text-h5"
                                                        v-text="
                                                            institucion.iniciales_nombre
                                                        "
                                                    ></span>
                                                </v-avatar>
                                                <span
                                                    class="text-h6 d-block mt-3"
                                                    >{{
                                                        institucion.nombre
                                                    }}</span
                                                >

                                                {{ institucion.dir }}
                                            </v-col>
                                            <v-divider vertical></v-divider>
                                            <v-col
                                                cols="10"
                                                sm="8"
                                                md="10"
                                                class="d-flex align-center"
                                            >
                                                <v-row>
                                                    <v-col cols="12">
                                                        <h4
                                                            class="text-center text-h6"
                                                        >
                                                            INFORMACIÓN
                                                        </h4>
                                                    </v-col>
                                                    <v-col
                                                        cols="6"
                                                        md="3"
                                                        xl="3"
                                                    >
                                                        <div
                                                            class="text-caption font-weight-bold"
                                                        >
                                                            Nombre Sistema
                                                        </div>
                                                        {{
                                                            institucion.nombre_sistema
                                                        }}
                                                    </v-col>
                                                    <v-col
                                                        cols="6"
                                                        md="3"
                                                        xl="3"
                                                    >
                                                        <div
                                                            class="text-caption font-weight-bold"
                                                        >
                                                            Nit
                                                        </div>
                                                        {{ institucion.nit }}
                                                    </v-col>
                                                    <v-col
                                                        cols="6"
                                                        md="3"
                                                        xl="3"
                                                    >
                                                        <div
                                                            class="text-caption font-weight-bold"
                                                        >
                                                            Director
                                                        </div>
                                                        {{
                                                            institucion.nombre_director
                                                        }}<v-avatar
                                                            class="ml-2"
                                                            :color="
                                                                institucion.url_foto_director
                                                                    ? 'grey'
                                                                    : 'blue'
                                                            "
                                                            size="40"
                                                        >
                                                            <v-img
                                                                cover
                                                                v-if="
                                                                    institucion.url_foto_director
                                                                "
                                                                :src="
                                                                    institucion.url_foto_director
                                                                "
                                                            ></v-img>
                                                            <span
                                                                v-else
                                                                class=""
                                                            >
                                                                {{
                                                                    institucion.iniciales_director
                                                                }}
                                                            </span>
                                                        </v-avatar>
                                                    </v-col>
                                                    <v-col
                                                        cols="6"
                                                        md="3"
                                                        xl="3"
                                                    >
                                                        <div
                                                            class="text-caption font-weight-bold"
                                                        >
                                                            Subdirector
                                                        </div>
                                                        {{
                                                            institucion.nombre_subdirector
                                                        }}
                                                        <v-avatar
                                                            class="ml-2"
                                                            :color="
                                                                institucion.url_foto_subdirector
                                                                    ? 'grey'
                                                                    : 'blue'
                                                            "
                                                            size="40"
                                                            v-if="
                                                                institucion.nombre_subdirector
                                                            "
                                                        >
                                                            <v-img
                                                                cover
                                                                v-if="
                                                                    institucion.url_foto_subdirector
                                                                "
                                                                :src="
                                                                    institucion.url_foto_subdirector
                                                                "
                                                            ></v-img>
                                                            <span
                                                                v-else
                                                                class=""
                                                            >
                                                                {{
                                                                    institucion.iniciales_subdirector
                                                                }}
                                                            </span>
                                                        </v-avatar>
                                                    </v-col>
                                                    <v-col
                                                        cols="6"
                                                        md="3"
                                                        xl="3"
                                                    >
                                                        <div
                                                            class="text-caption font-weight-bold"
                                                        >
                                                            Teléfono 1
                                                        </div>
                                                        {{ institucion.fono1 }}
                                                    </v-col>
                                                    <v-col
                                                        cols="6"
                                                        md="3"
                                                        xl="3"
                                                    >
                                                        <div
                                                            class="text-caption font-weight-bold"
                                                        >
                                                            Teléfono 2
                                                        </div>
                                                        {{ institucion.fono2 }}
                                                    </v-col>
                                                    <v-col
                                                        cols="6"
                                                        md="3"
                                                        xl="3"
                                                    >
                                                        <div
                                                            class="text-caption font-weight-bold"
                                                        >
                                                            Correo 1
                                                        </div>
                                                        {{
                                                            institucion.correo1
                                                        }}
                                                    </v-col>
                                                    <v-col
                                                        cols="6"
                                                        md="3"
                                                        xl="3"
                                                    >
                                                        <div
                                                            class="text-caption font-weight-bold"
                                                        >
                                                            Correo 2
                                                        </div>
                                                        {{
                                                            institucion.correo2
                                                        }}
                                                    </v-col>
                                                    <v-col
                                                        cols="6"
                                                        md="3"
                                                        xl="3"
                                                    >
                                                        <div
                                                            class="text-caption font-weight-bold"
                                                        >
                                                            Facebook
                                                        </div>
                                                        {{
                                                            institucion.facebook
                                                        }}
                                                    </v-col>
                                                    <v-col
                                                        cols="6"
                                                        md="3"
                                                        xl="3"
                                                    >
                                                        <div
                                                            class="text-caption font-weight-bold"
                                                        >
                                                            Youtube
                                                        </div>
                                                        {{
                                                            institucion.youtube
                                                        }}
                                                    </v-col>
                                                    <v-col
                                                        cols="6"
                                                        md="3"
                                                        xl="3"
                                                    >
                                                        <div
                                                            class="text-caption font-weight-bold"
                                                        >
                                                            Twitter
                                                        </div>
                                                        {{
                                                            institucion.twitter
                                                        }}
                                                    </v-col>
                                                </v-row>
                                            </v-col>
                                        </v-row>
                                    </v-card-text>
                                </v-card>
                            </v-col>
                            <v-col cols="12" sm="6" md="4">
                                <v-card>
                                    <v-card-title
                                        class="text-h6 text-center text-body-1 font-weight-black"
                                        >HISTORIA</v-card-title
                                    >
                                    <v-card-text>
                                        <v-col cols="12" class="text-center">
                                            <p
                                                class="text-caption text-justify"
                                                v-text="institucion.historia"
                                            ></p>
                                        </v-col>
                                    </v-card-text>
                                </v-card>
                            </v-col>
                            <v-col cols="12" sm="6" md="4">
                                <v-card>
                                    <v-card-title
                                        class="text-h6 text-center text-body-1 font-weight-black"
                                        >MISIÓN</v-card-title
                                    >
                                    <v-card-text>
                                        <v-col cols="12" class="text-center">
                                            <p
                                                class="text-caption text-justify"
                                                v-text="institucion.mision"
                                            ></p>
                                        </v-col>
                                    </v-card-text>
                                </v-card>
                            </v-col>
                            <v-col cols="12" sm="6" md="4">
                                <v-card>
                                    <v-card-title
                                        class="text-h6 text-center text-body-1 font-weight-black"
                                        >OBJETIVO</v-card-title
                                    >
                                    <v-card-text>
                                        <v-col cols="12" class="text-center">
                                            <p
                                                class="text-caption text-justify"
                                                v-text="institucion.objetivo"
                                            ></p>
                                        </v-col>
                                    </v-card-text>
                                </v-card>
                            </v-col>
                            <v-col cols="12" sm="6" md="6">
                                <v-card>
                                    <v-card-title
                                        class="text-center text-body-1 font-weight-black"
                                        >ORGANIGRAMA</v-card-title
                                    >
                                    <v-card-text>
                                        <v-col cols="12" class="text-center">
                                            <v-img
                                                cover
                                                v-if="
                                                    institucion.url_img_organigrama
                                                "
                                                :src="
                                                    institucion.url_img_organigrama
                                                "
                                            ></v-img>
                                        </v-col>
                                    </v-card-text>
                                </v-card>
                            </v-col>
                            <v-col cols="12" sm="6" md="6">
                                <v-card>
                                    <v-card-title
                                        class="text-h6 text-center text-body-1 font-weight-black"
                                        >UBICACIÓN GOOGLE MAPS</v-card-title
                                    >
                                    <v-card-text>
                                        <v-row>
                                            <v-col
                                                cols="12"
                                                class="ubicacion"
                                                v-html="
                                                    institucion.ubicacion_google
                                                "
                                            ></v-col>
                                        </v-row>
                                    </v-card-text>
                                </v-card>
                            </v-col>
                        </v-row>
                    </v-window-item>
                    <v-window-item :key="1">
                        <v-row>
                            <v-col cols="12">
                                <v-card>
                                    <v-card-title
                                        >Modificar información</v-card-title
                                    >
                                    <v-card-text>
                                        <v-container>
                                            <form @submit="enviaFormulario">
                                                <v-row>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-text-field
                                                            :hide-details="
                                                                form.errors
                                                                    ?.nombre
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.nombre
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.nombre
                                                                    ? form
                                                                          .errors
                                                                          ?.nombre
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            color="blue"
                                                            label="Nombre Institución*"
                                                            v-model="
                                                                form.nombre
                                                            "
                                                            required
                                                        ></v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-text-field
                                                            :hide-details="
                                                                form.errors
                                                                    ?.nombre_sistema
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.nombre_sistema
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.nombre_sistema
                                                                    ? form
                                                                          .errors
                                                                          ?.nombre_sistema
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            color="blue"
                                                            label="Nombre Sistema*"
                                                            v-model="
                                                                form.nombre_sistema
                                                            "
                                                            required
                                                        ></v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-text-field
                                                            :hide-details="
                                                                form.errors?.nit
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors?.nit
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors?.nit
                                                                    ? form
                                                                          .errors
                                                                          ?.nit
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            color="blue"
                                                            label="Nit*"
                                                            v-model="form.nit"
                                                            required
                                                        ></v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-text-field
                                                            :hide-details="
                                                                form.errors
                                                                    ?.nombre_director
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.nombre_director
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.nombre_director
                                                                    ? form
                                                                          .errors
                                                                          ?.nombre_director
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            color="blue"
                                                            label="Nombre Completo Director*"
                                                            v-model="
                                                                form.nombre_director
                                                            "
                                                            required
                                                        ></v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-file-input
                                                            :hide-details="
                                                                form.errors
                                                                    ?.foto_director
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.foto_director
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.foto_director
                                                                    ? form
                                                                          .errors
                                                                          ?.foto_director
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            accept="image/png, image/jpeg, image/bmp, image/webp"
                                                            placeholder="Foto Director"
                                                            prepend-icon="mdi-camera"
                                                            label="Foto Director"
                                                            @change="
                                                                cargaArchivo(
                                                                    $event,
                                                                    'foto_director'
                                                                )
                                                            "
                                                            ref="foto_director"
                                                        ></v-file-input>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-text-field
                                                            :hide-details="
                                                                form.errors
                                                                    ?.nombre_subdirector
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.nombre_subdirector
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.nombre_subdirector
                                                                    ? form
                                                                          .errors
                                                                          ?.nombre_subdirector
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            color="blue"
                                                            label="Nombre Completo Subirector"
                                                            v-model="
                                                                form.nombre_subdirector
                                                            "
                                                            required
                                                        ></v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-file-input
                                                            :hide-details="
                                                                form.errors
                                                                    ?.foto_subdirector
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.foto_subdirector
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.foto_subdirector
                                                                    ? form
                                                                          .errors
                                                                          ?.foto_subdirector
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            accept="image/png, image/jpeg, image/bmp, image/webp"
                                                            placeholder="Foto Subdirector"
                                                            prepend-icon="mdi-camera"
                                                            label="Foto Subdirector"
                                                            @change="
                                                                cargaArchivo(
                                                                    $event,
                                                                    'foto_subdirector'
                                                                )
                                                            "
                                                            ref="foto_subdirector"
                                                        ></v-file-input>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-text-field
                                                            :hide-details="
                                                                form.errors
                                                                    ?.fono1
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.fono1
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.fono1
                                                                    ? form
                                                                          .errors
                                                                          ?.fono1
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            color="blue"
                                                            label="Teléfono 1"
                                                            v-model="form.fono1"
                                                            required
                                                        ></v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-text-field
                                                            :hide-details="
                                                                form.errors
                                                                    ?.fono2
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.fono2
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.fono2
                                                                    ? form
                                                                          .errors
                                                                          ?.fono2
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            color="blue"
                                                            label="Teléfono 2"
                                                            v-model="form.fono2"
                                                            required
                                                        ></v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-text-field
                                                            :hide-details="
                                                                form.errors
                                                                    ?.correo1
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.correo1
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.correo1
                                                                    ? form
                                                                          .errors
                                                                          ?.correo1
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            color="blue"
                                                            label="Correo 1"
                                                            v-model="
                                                                form.correo1
                                                            "
                                                            required
                                                        ></v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-text-field
                                                            :hide-details="
                                                                form.errors
                                                                    ?.correo2
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.correo2
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.correo2
                                                                    ? form
                                                                          .errors
                                                                          ?.correo2
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            color="blue"
                                                            label="Correo 2"
                                                            v-model="
                                                                form.correo2
                                                            "
                                                            required
                                                        ></v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-text-field
                                                            :hide-details="
                                                                form.errors
                                                                    ?.facebook
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.facebook
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.facebook
                                                                    ? form
                                                                          .errors
                                                                          ?.facebook
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            color="blue"
                                                            label="Facebook"
                                                            v-model="
                                                                form.facebook
                                                            "
                                                            required
                                                        ></v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-text-field
                                                            :hide-details="
                                                                form.errors
                                                                    ?.youtube
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.youtube
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.youtube
                                                                    ? form
                                                                          .errors
                                                                          ?.youtube
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            color="blue"
                                                            label="Youtube"
                                                            v-model="
                                                                form.youtube
                                                            "
                                                            required
                                                        ></v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-text-field
                                                            :hide-details="
                                                                form.errors
                                                                    ?.twitter
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.twitter
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.twitter
                                                                    ? form
                                                                          .errors
                                                                          ?.twitter
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            color="blue"
                                                            label="Twitter"
                                                            v-model="
                                                                form.twitter
                                                            "
                                                            required
                                                        ></v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-text-field
                                                            :hide-details="
                                                                form.errors?.dir
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors?.dir
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors?.dir
                                                                    ? form
                                                                          .errors
                                                                          ?.dir
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            color="blue"
                                                            label="Dirección"
                                                            v-model="form.dir"
                                                            required
                                                        ></v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-file-input
                                                            :hide-details="
                                                                form.errors
                                                                    ?.logo
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.logo
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.logo
                                                                    ? form
                                                                          .errors
                                                                          ?.logo
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            accept="image/png, image/jpeg, image/bmp, image/webp"
                                                            placeholder="Logo"
                                                            prepend-icon="mdi-camera"
                                                            label="Logo"
                                                            @change="
                                                                cargaArchivo(
                                                                    $event,
                                                                    'logo'
                                                                )
                                                            "
                                                            ref="logo"
                                                        ></v-file-input>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6"
                                                        xl="4"
                                                    >
                                                        <v-file-input
                                                            :hide-details="
                                                                form.errors
                                                                    ?.organigrama
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.organigrama
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.organigrama
                                                                    ? form
                                                                          .errors
                                                                          ?.organigrama
                                                                    : ''
                                                            "
                                                            density="compact"
                                                            variant="outlined"
                                                            accept="image/png, image/jpeg, image/bmp, image/webp"
                                                            placeholder="Organigrama"
                                                            prepend-icon="mdi-camera"
                                                            label="Organigrama"
                                                            @change="
                                                                cargaArchivo(
                                                                    $event,
                                                                    'img_organigrama'
                                                                )
                                                            "
                                                            ref="img_organigrama"
                                                        ></v-file-input>
                                                    </v-col>
                                                </v-row>
                                                <v-row>
                                                    <v-col cols="12">
                                                        <v-textarea
                                                            :hide-details="
                                                                form.errors
                                                                    ?.historia
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.historia
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.historia
                                                                    ? form
                                                                          .errors
                                                                          ?.historia
                                                                    : ''
                                                            "
                                                            variant="outlined"
                                                            label="Historia"
                                                            rows="1"
                                                            auto-grow
                                                            v-model="
                                                                form.historia
                                                            "
                                                        ></v-textarea>
                                                    </v-col>
                                                    <v-col cols="12">
                                                        <v-textarea
                                                            :hide-details="
                                                                form.errors
                                                                    ?.mision
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.mision
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.mision
                                                                    ? form
                                                                          .errors
                                                                          ?.mision
                                                                    : ''
                                                            "
                                                            variant="outlined"
                                                            label="Misión"
                                                            rows="1"
                                                            auto-grow
                                                            v-model="
                                                                form.mision
                                                            "
                                                        ></v-textarea>
                                                    </v-col>
                                                    <v-col cols="12">
                                                        <v-textarea
                                                            :hide-details="
                                                                form.errors
                                                                    ?.objetivo
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.objetivo
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.objetivo
                                                                    ? form
                                                                          .errors
                                                                          ?.objetivo
                                                                    : ''
                                                            "
                                                            variant="outlined"
                                                            label="Objetivo General"
                                                            rows="1"
                                                            auto-grow
                                                            v-model="
                                                                form.objetivo
                                                            "
                                                        ></v-textarea>
                                                    </v-col>
                                                    <v-col cols="12">
                                                        <v-textarea
                                                            :hide-details="
                                                                form.errors
                                                                    ?.ubicacion_google
                                                                    ? false
                                                                    : true
                                                            "
                                                            :error="
                                                                form.errors
                                                                    ?.ubicacion_google
                                                                    ? true
                                                                    : false
                                                            "
                                                            :error-messages="
                                                                form.errors
                                                                    ?.ubicacion_google
                                                                    ? form
                                                                          .errors
                                                                          ?.ubicacion_google
                                                                    : ''
                                                            "
                                                            variant="outlined"
                                                            label="Ubicación Google Maps"
                                                            rows="1"
                                                            auto-grow
                                                            v-model="
                                                                form.ubicacion_google
                                                            "
                                                        ></v-textarea>
                                                    </v-col>
                                                </v-row>
                                            </form>
                                        </v-container>
                                    </v-card-text>
                                </v-card>
                            </v-col>
                        </v-row>
                    </v-window-item>
                </v-window>
            </v-col>
        </v-row>
    </v-container>
</template>
