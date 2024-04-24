<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Equipos Biomédicos",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>
<script setup>
import BreadBrums from "@/Components/BreadBrums.vue";
import { useApp } from "@/composables/useApp";
import { Head } from "@inertiajs/vue3";
import { useBiometricos } from "@/composables/biometricos/useBiometricos";
import { ref, onMounted } from "vue";
import { useMenu } from "@/composables/useMenu";
import Formulario from "./Formulario.vue";
const { mobile, identificaDispositivo } = useMenu();
const { setLoading } = useApp();
onMounted(() => {
    identificaDispositivo();
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const {
    getBiometricosApi,
    setBiometrico,
    limpiarBiometrico,
    deleteBiometrico,
} = useBiometricos();
const responseBiometricos = ref([]);
const listBiometricos = ref([]);
const itemsPerPage = ref(5);
const headers = ref([
    {
        title: "Id",
        align: "start",
        key: "id",
        sortable: false,
    },
    { title: "Nombre Equipo", align: "start", sortable: false },
    { title: "Estado", align: "start", sortable: false },
    { title: "Marca", align: "start", sortable: false },
    { title: "Serie", align: "start", sortable: false },
    { title: "Modelo", align: "start", sortable: false },
    { title: "Fecha de Ingreso", align: "start", sortable: false },
    { title: "Área", align: "start", sortable: false },
    { title: "Empresa", align: "start", sortable: false },
    { title: "Imagen", align: "start", sortable: false },
    { title: "Más", align: "start", sortable: false },
    { title: "Fecha Registro", align: "start", sortable: false },
    { title: "Acción", align: "end", sortable: false },
]);

const search = ref("");
const expanded = ref([]);
const options = ref({
    page: 1,
    itemsPerPage: itemsPerPage,
    sortBy: "",
    sortOrder: "desc",
    search: "",
    order: "desc",
});

const loading = ref(true);
const totalItems = ref(0);
let setTimeOutLoadData = null;
const loadItems = async ({ page, itemsPerPage, sortBy }) => {
    loading.value = true;
    options.value.page = page;
    if (sortBy.length > 0) {
        options.value.sortBy = sortBy[0].key;
        options.value.sortOrder = sortBy[0].order;
    }
    options.value.search = search.value;

    clearInterval(setTimeOutLoadData);
    setTimeOutLoadData = setTimeout(async () => {
        responseBiometricos.value = await getBiometricosApi(options.value);
        listBiometricos.value = responseBiometricos.value.data;
        totalItems.value = parseInt(responseBiometricos.value.total);
        loading.value = false;
    }, 300);
};
const recargaBiometricos = async () => {
    loading.value = true;
    listBiometricos.value = [];
    options.value.search = search.value;
    responseBiometricos.value = await getBiometricosApi(options.value);
    listBiometricos.value = responseBiometricos.value.data;
    totalItems.value = parseInt(responseBiometricos.value.total);
    setTimeout(() => {
        loading.value = false;
        open_dialog.value = false;
    }, 300);
};
const accion_dialog = ref(0);
const open_dialog = ref(false);
const agregarRegistro = () => {
    limpiarBiometrico();
    accion_dialog.value = 0;
    open_dialog.value = true;
};
const editarBiometrico = (item) => {
    setBiometrico(item);
    accion_dialog.value = 1;
    open_dialog.value = true;
};
const eliminarBiometrico = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>${item.nombre}</strong>`,
        showCancelButton: true,
        confirmButtonColor: "#B61431",
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await deleteBiometrico(item.id);
            if (respuesta && respuesta.sw) {
                recargaBiometricos();
            }
        }
    });
};
</script>
<template>
    <Head title="Equipos Biomédicos"></Head>
    <v-container>
        <BreadBrums :breadbrums="breadbrums"></BreadBrums>
        <v-row class="mt-0">
            <v-col cols="12" class="d-flex justify-end">
                <v-btn
                    color="yellow-lighten-1"
                    prepend-icon="mdi-plus"
                    @click="agregarRegistro"
                >
                    Agregar</v-btn
                >
            </v-col>
        </v-row>
        <v-row class="mt-0">
            <v-col cols="12">
                <v-card flat>
                    <v-card-title>
                        <v-row
                            class="bg-grey-darken-3 d-flex align-center pa-3"
                        >
                            <v-col cols="12" sm="6" md="4">Equipos Biomédicos </v-col>
                            <v-col cols="12" sm="6" md="4" offset-md="4">
                                <v-text-field
                                    v-model="search"
                                    label="Buscar"
                                    append-inner-icon="mdi-magnify"
                                    variant="underlined"
                                    clearable
                                    hide-details
                                ></v-text-field>
                            </v-col>
                        </v-row>
                    </v-card-title>
                    <v-card-text>
                        <v-data-table-server
                            v-model:items-per-page="itemsPerPage"
                            :headers="!mobile ? headers : []"
                            :class="[mobile ? 'mobile' : '']"
                            :items-length="totalItems"
                            :items="listBiometricos"
                            :loading="loading"
                            :search="search"
                            @update:options="loadItems"
                            height="auto"
                            no-data-text="No se encontrarón registros"
                            loading-text="Cargando..."
                            page-text="{0} - {1} de {2}"
                            items-per-page-text="Registros por página"
                            :items-per-page-options="[
                                { value: 10, title: '10' },
                                { value: 25, title: '25' },
                                { value: 50, title: '50' },
                                { value: 100, title: '100' },
                                {
                                    value: -1,
                                    title: 'Todos',
                                },
                            ]"
                        >
                            <template v-slot:expanded-item="{ headers, item }">
                                <td :colspan="headers.length">
                                    <div class="row sp-details">
                                        <div class="col-4 text-right">
                                            <v-text-field
                                                v-model="input1"
                                                label="Label"
                                            ></v-text-field>
                                        </div>
                                        <div class="col-4 text-right">
                                            <v-text-field
                                                v-model="input2"
                                                label="Label 1"
                                            ></v-text-field>
                                        </div>
                                        <div class="col-4 text-right">
                                            <v-text-field
                                                v-model="input3"
                                                label="Label 2"
                                            ></v-text-field>
                                        </div>
                                    </div>
                                </td>
                            </template>

                            <template v-slot:item="{ item }">
                                <template v-if="!mobile">
                                    <tr>
                                        <td>{{ item.id }}</td>
                                        <td>{{ item.nombre }}</td>
                                        <td>{{ item.estado }}</td>
                                        <td>{{ item.marca }}</td>
                                        <td>{{ item.serie }}</td>
                                        <td>{{ item.modelo }}</td>
                                        <td>{{ item.fecha_ingreso_t }}</td>
                                        <td>{{ item.unidad_area.nombre }}</td>
                                        <td>{{ item.empresa?.nombre }}</td>
                                        <td>
                                            <v-card
                                                class="my-2"
                                                elevation="2"
                                                rounded
                                                v-if="item.url_foto"
                                            >
                                                <v-img
                                                    :src="item.url_foto"
                                                    height="64"
                                                    cover
                                                ></v-img>
                                            </v-card>
                                            <v-avatar
                                                v-else
                                                color="yellow-lighten-1"
                                                size="45"
                                            >
                                                <span class="text-body-1">{{
                                                    item.iniciales_nombre
                                                }}</span>
                                            </v-avatar>
                                        </td>
                                        <td>
                                            <v-btn
                                                :icon="
                                                    item.mas
                                                        ? 'mdi-chevron-down'
                                                        : 'mdi-chevron-left'
                                                "
                                                @click="item.mas = !item.mas"
                                            ></v-btn>
                                        </td>
                                        <td>{{ item.fecha_registro_t }}</td>
                                        <td class="text-right">
                                            <v-btn
                                                color="yellow"
                                                size="small"
                                                class="pa-1 ma-1"
                                                @click="editarBiometrico(item)"
                                                icon="mdi-pencil"
                                            ></v-btn>
                                            <v-btn
                                                color="error"
                                                size="small"
                                                class="pa-1 ma-1"
                                                @click="
                                                    eliminarBiometrico(item)
                                                "
                                                icon="mdi-trash-can"
                                            ></v-btn>
                                        </td>
                                    </tr>
                                    <tr v-if="item.mas">
                                        <td
                                            :colspan="headers.length"
                                            class="py-5"
                                        >
                                            <v-row>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Garantía</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.garantia
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Código H.D.N</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.cod_hdn
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Manual de
                                                            Usuario</v-col
                                                        >
                                                        <v-col cols="12"
                                                            ><a
                                                                :href="
                                                                    item.url_manual_usuario
                                                                "
                                                                target="_blank"
                                                                >{{
                                                                    item.manual_usuario
                                                                }}</a
                                                            ></v-col
                                                        >
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Manual de
                                                            Servicio</v-col
                                                        >
                                                        <v-col cols="12">
                                                            <a
                                                                :href="
                                                                    item.url_manual_servicio
                                                                "
                                                                target="_blank"
                                                                >{{
                                                                    item.manual_servicio
                                                                }}</a
                                                            >
                                                        </v-col>
                                                    </v-row>
                                                </v-col>
                                            </v-row>
                                        </td>
                                    </tr>
                                </template>
                                <template v-else>
                                    <tr>
                                        <td>
                                            <ul class="flex-content">
                                                <li
                                                    class="flex-item"
                                                    data-label="Id"
                                                >
                                                    {{ item.id }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Nombre Equipo"
                                                >
                                                    {{ item.nombre }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Estado"
                                                >
                                                    {{ item.estado }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Marca"
                                                >
                                                    {{ item.marca }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Serie"
                                                >
                                                    {{ item.serie }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Modelo"
                                                >
                                                    {{ item.modelo }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Fecha de Ingreso"
                                                >
                                                    {{ item.fecha_ingreso_t }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Garantía"
                                                >
                                                    {{ item.garantia }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Código H.D.N."
                                                >
                                                    {{ item.cod_hdn }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Manual de usuario"
                                                >
                                                    <a
                                                        :href="
                                                            item.url_manual_usuario
                                                        "
                                                        target="_blank"
                                                        >{{
                                                            item.manual_usuario
                                                        }}</a
                                                    >
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Manual de servicio"
                                                >
                                                    <a
                                                        :href="
                                                            item.url_manual_servicio
                                                        "
                                                        target="_blank"
                                                        >{{
                                                            item.manual_servicio
                                                        }}</a
                                                    >
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Área"
                                                >
                                                    {{
                                                        item.unidad_area.nombre
                                                    }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Empresa"
                                                >
                                                    {{ item.empresa?.nombre }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Imagen"
                                                >
                                                    <v-card
                                                        class="my-2"
                                                        elevation="2"
                                                        rounded
                                                        v-if="item.url_foto"
                                                        width="120"
                                                    >
                                                        <v-img
                                                            :src="item.url_foto"
                                                            height="64"
                                                            cover
                                                        ></v-img>
                                                    </v-card>
                                                    <v-avatar
                                                        v-else
                                                        color="yellow-lighten-1"
                                                        size="45"
                                                    >
                                                        <span
                                                            class="text-body-1"
                                                            >{{
                                                                item.iniciales_nombre
                                                            }}</span
                                                        >
                                                    </v-avatar>
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Fecha Registro"
                                                >
                                                    {{ item.fecha_registro_t }}
                                                </li>
                                            </ul>
                                            <v-row>
                                                <v-col
                                                    cols="12"
                                                    class="text-center pa-5"
                                                >
                                                    <v-btn
                                                        color="yellow"
                                                        size="small"
                                                        class="pa-1 ma-1"
                                                        @click="
                                                            editarBiometrico(
                                                                item
                                                            )
                                                        "
                                                        icon="mdi-pencil"
                                                    ></v-btn>
                                                    <v-btn
                                                        color="error"
                                                        size="small"
                                                        class="pa-1 ma-1"
                                                        @click="
                                                            eliminarBiometrico(
                                                                item
                                                            )
                                                        "
                                                        icon="mdi-trash-can"
                                                    ></v-btn>
                                                </v-col>
                                            </v-row>
                                        </td>
                                    </tr>
                                </template>
                            </template>
                        </v-data-table-server>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
        <Formulario
            :open_dialog="open_dialog"
            :accion_dialog="accion_dialog"
            @envio-formulario="recargaBiometricos"
            @cerrar-dialog="open_dialog = false"
        ></Formulario>
    </v-container>
</template>
