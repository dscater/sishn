<script setup>
import { router, usePage } from "@inertiajs/vue3";
import { useDocumentos } from "@/composables/documentos/useDocumentos";
import { watch, ref, computed, defineEmits } from "vue";
import axios from "axios";
const props = defineProps({
    open_dialog: {
        type: Boolean,
        default: false,
    },
    accion_dialog: {
        type: Number,
        default: 0,
    },
});

const { oDocumento, setDocumento } = useDocumentos();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
watch(
    () => props.open_dialog,
    (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
        }
    }
);
watch(
    () => props.accion_dialog,
    (newValue) => {
        accion.value = newValue;
    }
);

const { flash } = usePage().props;

const tituloDialog = computed(() => {
    return accion.value == 0 ? `Documentos > Archivos` : ``;
});

const emits = defineEmits(["cerrar-dialog", "envio-formulario"]);

watch(dialog, (newVal) => {
    if (!newVal) {
        emits("cerrar-dialog");
    }
});

const eliminarArchivo = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>${item.archivo}</strong>`,
        showCancelButton: true,
        confirmButtonColor: "#B61431",
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            axios
                .post(route("documento_archivos.destroy", item.id), {
                    _method: "delete",
                })
                .then((response) => {
                    setDocumento(
                        response.data.documento,
                        true
                    );
                    emits("envio-formulario");
                });
        }
    });
};

const descargar = (item) => {
    window.open(item.url_archivo, "_blank");
};

const cerrarDialog = () => {
    dialog.value = false;
};
</script>

<template>
    <v-row justify="center">
        <v-dialog v-model="dialog" width="1024" persistent scrollable>
            <v-card>
                <v-card-title class="border-b bg-indigo-darken-4 pa-5">
                    <v-icon
                        icon="mdi-close"
                        class="float-right"
                        @click="cerrarDialog"
                    ></v-icon>

                    <v-icon
                        :icon="accion == 0 ? 'mdi-paperclip' : 'mdi-pencil'"
                    ></v-icon>
                    <span class="text-h5" v-html="tituloDialog"></span>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12">
                                <v-table>
                                    <thead>
                                        <tr>
                                            <th class="text-left" width="20px">
                                                N°
                                            </th>
                                            <th class="text-left">Archivo</th>
                                            <th class="text-center">
                                                Previsualizacion
                                            </th>
                                            <th class="text-center">Acción</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr
                                            v-for="(
                                                item, index
                                            ) in oDocumento.documento_archivos"
                                        >
                                            <td>{{ index + 1 }}</td>
                                            <td>{{ item.archivo }}</td>
                                            <td class="text-center">
                                                <img
                                                    :src="item.thumb"
                                                    alt="Previsualizacion"
                                                    width="50px"
                                                />
                                            </td>
                                            <td class="text-center">
                                                <v-btn
                                                    class="mr-2"
                                                    icon="mdi-download"
                                                    size="small"
                                                    @click="descargar(item)"
                                                ></v-btn>
                                                <v-btn
                                                    class="bg-red-darken-3"
                                                    icon="mdi-trash-can-outline"
                                                    size="small"
                                                    @click="
                                                        eliminarArchivo(item)
                                                    "
                                                ></v-btn>
                                            </td>
                                        </tr>
                                    </tbody>
                                </v-table>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions class="border-t">
                    <v-spacer></v-spacer>
                    <v-btn
                        color="grey-darken-4"
                        variant="text"
                        @click="cerrarDialog"
                    >
                        Cerrar
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-row>
</template>
