<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useDocumentos } from "@/composables/documentos/useDocumentos";
import { useMenu } from "@/composables/useMenu";
import { watch, ref, reactive, computed, onMounted } from "vue";
import MiDropZone from "@/Components/MiDropZone.vue";

const { mobile, cambiarUrl } = useMenu();
const { oDocumento, limpiarDocumento } = useDocumentos();
let form = useForm(oDocumento);

const { flash, auth } = usePage().props;
const user = ref(auth.user);

const tituloDialog = computed(() => {
    return oDocumento.id == 0 ? `Agregar Documentos` : `Editar Documentos`;
});

const disabled = ref(false);

const enviarFormulario = () => {
    let url =
        form["_method"] == "POST"
            ? route("documentos.store")
            : route("documentos.update", form.id);

    form.post(url, {
        preserveScroll: true,
        forceFormData: true,
        onSuccess: () => {
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            limpiarDocumento();
            cambiarUrl(route("documentos.index"));
        },
        onError: (err) => {
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.error
                        ? err.error
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
        },
    });
};

const detectaArchivos = (files) => {
    disabled.value = true;
    form.documento_archivos = [];
    for (let i = 0; i < files.length; i++) {
        const file = files[i];
        form.documento_archivos.push(file.file);
    }
    setTimeout(() => {
        disabled.value = false;
    }, 500);
};

onMounted(() => {});
</script>

<template>
    <v-row class="mt-0">
        <v-col cols="12" class="d-flex justify-end">
            <template v-if="mobile">
                <v-btn
                    icon="mdi-arrow-left"
                    class="mr-2"
                    @click="cambiarUrl(route('documentos.index'))"
                ></v-btn>
                <v-btn
                    :disabled="disabled"
                    icon="mdi-content-save"
                    color="indigo-darken-4"
                    @click="enviarFormulario"
                ></v-btn>
            </template>
            <template v-if="!mobile">
                <v-btn
                    prepend-icon="mdi-arrow-left"
                    class="mr-2"
                    @click="cambiarUrl(route('documentos.index'))"
                >
                    Volver</v-btn
                >
                <v-btn
                    :disabled="disabled"
                    :prepend-icon="
                        oDocumento.id != 0 ? 'mdi-sync' : 'mdi-content-save'
                    "
                    color="indigo-darken-4"
                    @click="enviarFormulario"
                >
                    <span
                        v-text="
                            oDocumento.id != 0
                                ? 'Actualizar Documentos'
                                : 'Guardar Documentos'
                        "
                    ></span
                ></v-btn>
            </template>
        </v-col>
    </v-row>
    <v-row>
        <v-col cols="12">
            <v-card>
                <v-card-title class="border-b bg-indigo-darken-4 pa-5">
                    <v-icon
                        :icon="form.id == 0 ? 'mdi-plus' : 'mdi-pencil'"
                    ></v-icon>
                    <span class="text-h5" v-html="tituloDialog"></span>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <form @submit.prevent="enviarFormulario">
                            <v-row>
                                <v-col cols="12">
                                    <v-textarea
                                        :hide-details="
                                            form.errors?.descripcion
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.descripcion
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.descripcion
                                                ? form.errors?.descripcion
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Descripción*"
                                        rows="1"
                                        auto-grow
                                        density="compact"
                                        v-model="form.descripcion"
                                    ></v-textarea>
                                </v-col>
                                <v-col cols="12">
                                    <h4>Cargar archivos</h4>
                                </v-col>
                                <v-col cols="12">
                                    <MiDropZone
                                        :files="[]"
                                        @UpdateFiles="detectaArchivos"
                                    ></MiDropZone>
                                </v-col>
                            </v-row>
                        </form>
                    </v-container>
                </v-card-text>
            </v-card>
        </v-col>
    </v-row>
</template>

<style scoped>
#google_map {
    width: 100%;
    height: 500px;
}
</style>
