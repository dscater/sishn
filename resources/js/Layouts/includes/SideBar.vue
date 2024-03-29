<script setup>
import { useMenu } from "@/composables/useMenu";
import { onMounted, ref } from "vue";
import { usePage, router } from "@inertiajs/vue3";
import { useUser } from "@/composables/useUser";
const { oUser } = useUser();

// data
const {
    mobile,
    drawer,
    rail,
    width,
    menu_open,
    setMenuOpen,
    cambiarUrl,
    toggleDrawer,
} = useMenu();

const user_logeado = ref({
    permisos: [],
});

const submenus = {
    "reportes.usuarios": "Reportes",
    "reportes.solicitud_mantenimiento": "Reportes",
    "reportes.servicio": "Reportes",
    "reportes.equipos": "Reportes",
};

const route_current = ref("");

router.on("navigate", (event) => {
    route_current.value = route().current();
    if (mobile.value) {
        toggleDrawer(false);
    }
});

const { props: props_page } = usePage();

onMounted(() => {
    let route_actual = route().current();
    // buscar en submenus y abrirlo si uno de sus elementos esta activo
    setMenuOpen([]);
    if (submenus[route_actual]) {
        setMenuOpen([submenus[route_actual]]);
    }

    if (props_page.auth) {
        user_logeado.value = props_page.auth?.user;
    }

    setTimeout(() => {
        scrollActive();
    }, 300);
});

const scrollActive = () => {
    let sidebar = document.querySelector("#sidebar");
    let menu = null;
    let activeChild = null;
    if (sidebar) {
        menu = sidebar.querySelector(".v-navigation-drawer__content");
        activeChild = sidebar.querySelector(".active");
    }
    // Verifica si se encontró un hijo activo
    if (activeChild) {
        let offsetTop = activeChild.offsetTop - sidebar.offsetTop;
        setTimeout(() => {
            menu.scrollTo({
                top: offsetTop,
                behavior: "smooth", // desplazamiento suave
            });
        }, 500);
    }
};
</script>
<template>
    <v-navigation-drawer
        :permanent="!mobile"
        :temporary="mobile"
        v-model="drawer"
        class="border-0 elevation-2 __sidebar"
        :width="width"
        id="sidebar"
        color="grey-darken-4"
    >
        <v-sheet>
            <div
                class="w-100 d-flex flex-column align-center elevation-1 bg-yellow-lighten-1 pa-2 __info_usuario"
            >
                <v-avatar
                    class="mb-1"
                    color="grey-darken-3"
                    :size="`${!rail ? '64' : '32'}`"
                >
                    <v-img
                        cover
                        v-if="oUser.url_foto"
                        :src="oUser.url_foto"
                    ></v-img>
                    <span v-else class="text-h5">
                        {{ oUser.iniciales_nombre }}
                    </span>
                </v-avatar>
                <div v-show="!rail" class="text-caption font-weight-bold">
                    {{ oUser.tipo }}
                </div>
                <div v-show="!rail" class="text-body">
                    {{ oUser.full_name }}
                </div>
            </div>
        </v-sheet>

        <v-list class="mt-1 px-2" v-model:opened="menu_open">
            <v-list-item class="text-caption">
                <span v-if="rail && !mobile" class="text-center d-block"
                    ><v-icon>mdi-dots-horizontal</v-icon></span
                >
                <span v-else>INICIO</span></v-list-item
            >
            <v-list-item
                prepend-icon="mdi-home-outline"
                :class="[route_current == 'inicio' ? 'active' : '']"
                @click="cambiarUrl(route('inicio'))"
                link
            >
                <v-list-item-title>Inicio</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Inicio</v-tooltip
                >
            </v-list-item>
            <v-list-item
                class="text-caption"
                v-if="
                    oUser.permisos.includes('usuarios.index') ||
                    oUser.permisos.includes('servicios.index') ||
                    oUser.permisos.includes('solicitud_mantenimientos.index') ||
                    oUser.permisos.includes('biometricos.index') ||
                    oUser.permisos.includes('empresas.index') ||
                    oUser.permisos.includes('unidad_areas.index')
                "
            >
                <span v-if="rail && !mobile" class="text-center d-block"
                    ><v-icon>mdi-dots-horizontal</v-icon></span
                >
                <span v-else>ADMINISTRACIÓN</span></v-list-item
            >
            <v-list-item
                :class="[
                    route_current == 'servicios.index' ||
                    route_current == 'servicios.create' ||
                    route_current == 'servicios.edit'
                        ? 'active'
                        : '',
                ]"
                v-if="oUser.permisos.includes('servicios.index')"
                prepend-icon="mdi-list-box"
                @click="cambiarUrl(route('servicios.index'))"
                link
            >
                <v-list-item-title>Servicios</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Servicios</v-tooltip
                >
            </v-list-item>
            <v-list-item
                :class="[
                    route_current == 'solicitud_mantenimientos.index' ||
                    route_current == 'solicitud_mantenimientos.create' ||
                    route_current == 'solicitud_mantenimientos.edit' ||
                    route_current == 'solicitud_mantenimientos.cronogramas'
                        ? 'active'
                        : '',
                ]"
                v-if="oUser.permisos.includes('solicitud_mantenimientos.index')"
                prepend-icon="mdi-clipboard-list"
                @click="cambiarUrl(route('solicitud_mantenimientos.index'))"
                link
            >
                <v-list-item-title
                    >Solicitud de Mantenimiento</v-list-item-title
                >
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Solicitud de Mantenimiento</v-tooltip
                >
            </v-list-item>
            <v-list-item
                :class="[route_current == 'biometricos.index' ? 'active' : '']"
                v-if="oUser.permisos.includes('biometricos.index')"
                prepend-icon="mdi-list-box"
                @click="cambiarUrl(route('biometricos.index'))"
                link
            >
                <v-list-item-title>Equipos Biométricos</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Equipos Biométricos</v-tooltip
                >
            </v-list-item>
            <v-list-item
                :class="[route_current == 'empresas.index' ? 'active' : '']"
                v-if="oUser.permisos.includes('empresas.index')"
                prepend-icon="mdi-office-building"
                @click="cambiarUrl(route('empresas.index'))"
                link
            >
                <v-list-item-title>Empresas</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Empresas</v-tooltip
                >
            </v-list-item>
            <v-list-item
                :class="[route_current == 'unidad_areas.index' ? 'active' : '']"
                v-if="oUser.permisos.includes('unidad_areas.index')"
                prepend-icon="mdi-view-list"
                @click="cambiarUrl(route('unidad_areas.index'))"
                link
            >
                <v-list-item-title>Unidades/Áreas</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Unidades/Áreas</v-tooltip
                >
            </v-list-item>

            <v-list-item
                :class="[route_current == 'usuarios.index' ? 'active' : '']"
                v-if="oUser.permisos.includes('usuarios.index')"
                prepend-icon="mdi-account-group"
                @click="cambiarUrl(route('usuarios.index'))"
                link
            >
                <v-list-item-title>Usuarios</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Usuarios</v-tooltip
                >
            </v-list-item>

            <v-list-item
                class="text-caption"
                v-if="
                    oUser.permisos.includes('reportes.usuarios') ||
                    oUser.permisos.includes(
                        'reportes.solicitud_mantenimiento'
                    ) ||
                    oUser.permisos.includes('reportes.servicio')
                "
                ><span v-if="rail && !mobile" class="text-center d-block"
                    ><v-icon>mdi-dots-horizontal</v-icon></span
                >
                <span v-else>REPORTES</span></v-list-item
            >
            <!-- SUBGROUP -->
            <v-list-group
                value="Reportes"
                v-if="
                    oUser.permisos.includes('reportes.usuarios') ||
                    oUser.permisos.includes(
                        'reportes.solicitud_mantenimiento'
                    ) ||
                    oUser.permisos.includes('reportes.servicio') ||
                    oUser.permisos.includes('reportes.equipos')
                "
            >
                <template v-slot:activator="{ props }">
                    <v-list-item
                        v-bind="props"
                        prepend-icon="mdi-file-document-multiple"
                        title="Reportes"
                        :class="[
                            route_current == 'reportes.usuarios' ||
                            route_current ==
                                'reportes.solicitud_mantenimiento' ||
                            route_current == 'reportes.servicio' ||
                            route_current == 'reportes.equipos'
                                ? 'active'
                                : '',
                        ]"
                    >
                        <v-tooltip
                            v-if="rail && !mobile"
                            color="white"
                            activator="parent"
                            location="end"
                            >Reportes</v-tooltip
                        ></v-list-item
                    >
                </template>
                <v-list-item
                    v-if="oUser.permisos.includes('reportes.usuarios')"
                    prepend-icon="mdi-chevron-right"
                    title="Usuarios"
                    :class="[
                        route_current == 'reportes.usuarios' ? 'active' : '',
                    ]"
                    @click="cambiarUrl(route('reportes.usuarios'))"
                    link
                >
                    <v-tooltip
                        v-if="rail && !mobile"
                        color="white"
                        activator="parent"
                        location="end"
                        >Usuarios</v-tooltip
                    ></v-list-item
                >
                <v-list-item
                    v-if="
                        oUser.permisos.includes(
                            'reportes.solicitud_mantenimiento'
                        )
                    "
                    prepend-icon="mdi-chevron-right"
                    title="Solicitud de Mantenimiento"
                    :class="[
                        route_current == 'reportes.solicitud_mantenimiento'
                            ? 'active'
                            : '',
                    ]"
                    @click="
                        cambiarUrl(route('reportes.solicitud_mantenimiento'))
                    "
                    link
                >
                    <v-tooltip
                        v-if="rail && !mobile"
                        color="white"
                        activator="parent"
                        location="end"
                        >Solicitud de Mantenimiento</v-tooltip
                    ></v-list-item
                >
                <v-list-item
                    v-if="oUser.permisos.includes('reportes.servicio')"
                    prepend-icon="mdi-chevron-right"
                    title="Informe de Servicio"
                    :class="[
                        route_current == 'reportes.servicio' ? 'active' : '',
                    ]"
                    @click="cambiarUrl(route('reportes.servicio'))"
                    link
                >
                    <v-tooltip
                        v-if="rail && !mobile"
                        color="white"
                        activator="parent"
                        location="end"
                        >Informe de Servicio</v-tooltip
                    ></v-list-item
                >
                <v-list-item
                    v-if="oUser.permisos.includes('reportes.equipos')"
                    prepend-icon="mdi-chevron-right"
                    title="Lista de Equipos"
                    :class="[
                        route_current == 'reportes.equipos' ? 'active' : '',
                    ]"
                    @click="cambiarUrl(route('reportes.equipos'))"
                    link
                >
                    <v-tooltip
                        v-if="rail && !mobile"
                        color="white"
                        activator="parent"
                        location="end"
                        >Lista de Equipos</v-tooltip
                    ></v-list-item
                >
            </v-list-group>
            <!-- ################################################ -->
            <v-list-item class="text-caption"
                ><span v-if="rail && !mobile" class="text-center d-block"
                    ><v-icon>mdi-dots-horizontal</v-icon></span
                >
                <span v-else>OTROS</span></v-list-item
            >
            <v-list-item
                :class="[route_current == 'repuestos.index' ? 'active' : '']"
                v-if="oUser.permisos.includes('repuestos.index')"
                prepend-icon="mdi-list-box"
                @click="cambiarUrl(route('repuestos.index'))"
                link
            >
                <v-list-item-title>Repuestos</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Repuestos</v-tooltip
                >
            </v-list-item>
            <v-list-item
                v-if="oUser.permisos.includes('institucions.index')"
                prepend-icon="mdi-cog-outline"
                :class="[route_current == 'institucions.index' ? 'active' : '']"
                @click="cambiarUrl(route('institucions.index'))"
                link
            >
                <v-list-item-title>Institución</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Institución</v-tooltip
                >
            </v-list-item>
            <v-list-item
                prepend-icon="mdi-account-circle"
                :class="[route_current == 'profile.edit' ? 'active' : '']"
                @click="cambiarUrl(route('profile.edit'))"
                link
            >
                <v-list-item-title>Perfil</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Perfil</v-tooltip
                >
            </v-list-item>
            <v-list-item
                prepend-icon="mdi-logout"
                @click="cambiarUrl(route('logout'), 'post')"
                link
            >
                <v-list-item-title>Salir</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Salir</v-tooltip
                >
            </v-list-item>
        </v-list>
    </v-navigation-drawer>
</template>
<style scoped></style>
