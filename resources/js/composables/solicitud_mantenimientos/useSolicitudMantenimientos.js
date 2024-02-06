import { useForm } from "@inertiajs/vue3";
import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oSolicitudMantenimiento = ref({
    id: 0,
    nombre: "",
    _method: "POST",
});

export const useSolicitudMantenimientos = () => {
    const { flash } = usePage().props;
    const getSolicitudMantenimientos = async () => {
        try {
            const response = await axios.get(route("solicitud_mantenimientos.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.solicitud_mantenimientos;
        } catch (err) {
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.error
                        ? err.error
                        : "Error al obtener los registros"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            console.error("Error:", err);
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const getSolicitudMantenimientosApi = async (data) => {
        try {
            const response = await axios.get(
                route("solicitud_mantenimientos.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.solicitud_mantenimientos;
        } catch (err) {
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.error
                        ? err.error
                        : "Error al obtener los registros"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            console.error("Error:", err);
            throw err; // Puedes manejar el error según tus necesidades
        }
    };
    const saveSolicitudMantenimiento = async (data) => {
        try {
            const response = await axios.post(
                route("solicitud_mantenimientos.store", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            return response.data;
        } catch (err) {
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
            console.error("Error:", err);
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const deleteSolicitudMantenimiento = async (id) => {
        try {
            const response = await axios.delete(
                route("solicitud_mantenimientos.destroy", id),
                {
                    headers: { Accept: "application/json" },
                }
            );
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            return response.data;
        } catch (err) {
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
            console.error("Error:", err);
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const setSolicitudMantenimiento = (item = null) => {
        if (item) {
            oSolicitudMantenimiento.value.id = item.id;
            oSolicitudMantenimiento.value.nombre = item.nombre;
            oSolicitudMantenimiento.value._method = "PUT";
            return oSolicitudMantenimiento;
        }
        return false;
    };

    const limpiarSolicitudMantenimiento = () => {
        oSolicitudMantenimiento.value.id = 0;
        oSolicitudMantenimiento.value.nombre = "";
        oSolicitudMantenimiento.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oSolicitudMantenimiento,
        getSolicitudMantenimientos,
        getSolicitudMantenimientosApi,
        saveSolicitudMantenimiento,
        deleteSolicitudMantenimiento,
        setSolicitudMantenimiento,
        limpiarSolicitudMantenimiento,
    };
};
