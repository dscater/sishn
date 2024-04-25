<script setup>
import { ref, onMounted } from "vue";
import { useInstitucion } from "@/composables/useInstitucion";
import { Link, usePage } from "@inertiajs/vue3";

const { getInstitucion, oInstitucion } = useInstitucion();
const { props } = usePage();
const user = props.auth.user;

onMounted(() => {
    getInstitucion();
    console.log(oInstitucion);
    console.log(user);
});
</script>
<template>
    <v-app id="inspire">
        <v-app-bar color="yellow">
            <v-app-bar-title>{{ oInstitucion.nombre }}</v-app-bar-title>

            <template v-slot:append>
                <Link
                    :href="route('login')"
                    class="text-grey-darken-4 text-decoration-none"
                    v-if="!user"
                    ><v-icon>mdi-login</v-icon> Acceder</Link
                >
                <Link
                    :href="route('inicio')"
                    class="text-grey-darken-4 text-decoration-none"
                    v-else
                    ><v-icon>mdi-home</v-icon> Inicio</Link
                >
            </template>
        </v-app-bar>
        <v-main>
            <slot />
        </v-main>

        <v-footer
            class="d-flex flex-column pl-0 pr-0 pt-4 pb-4 bg-grey-darken-4"
        >
            <div>
                <a
                    :href="oInstitucion.youtube"
                    target="_blank"
                    class="mx-4 text-white text-decoration-none text-info"
                    variant="text"
                    ><v-icon>mdi-twitter</v-icon></a
                >
                <a
                    :href="oInstitucion.youtube"
                    target="_blank"
                    class="mx-4 text-white text-decoration-none text-error"
                    variant="text"
                    ><v-icon>mdi-youtube</v-icon></a
                >
                <a
                    :href="oInstitucion.youtube"
                    target="_blank"
                    class="mx-4 text-white text-decoration-none text-blue-darken-3"
                    variant="text"
                    ><v-icon>mdi-facebook</v-icon></a
                >
            </div>
            <div>
                <a
                    :href="'mailto:' + oInstitucion.correo1"
                    target="_blank"
                    class="text-decoration-none text-white text-caption"
                    ><v-icon icon="mdi-email"></v-icon>
                    {{ oInstitucion.correo1 }}</a
                >
                &nbsp;&nbsp;
                <a
                    :href="'mailto:' + oInstitucion.correo2"
                    target="_blank"
                    class="text-decoration-none text-white text-caption"
                    ><v-icon icon="mdi-email"></v-icon>
                    {{ oInstitucion.correo2 }}</a
                >
            </div>

            <div class="px-4 py-2 text-center w-100">
                <strong>{{ oInstitucion.nombre_sistema }}</strong> —
                {{ new Date().getFullYear() }}
            </div>
        </v-footer>
    </v-app>
</template>
<style scoped>
.v-main {
    background: #1b1b1b !important;
}
</style>
