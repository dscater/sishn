import { useForm } from "@inertiajs/vue3";
import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oRepuesto = ref({
    id: 0,
    nombre: "",
    _method: "POST",
});

export const useRepuestos = () => {
    const { flash } = usePage().props;
    const getRepuestos = async () => {
        try {
            const response = await axios.get(route("repuestos.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.repuestos;
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

    const getRepuestosApi = async (data) => {
        try {
            const response = await axios.get(
                route("repuestos.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.repuestos;
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
    const saveRepuesto = async (data) => {
        try {
            const response = await axios.post(
                route("repuestos.store", data),
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

    const deleteRepuesto = async (id) => {
        try {
            const response = await axios.delete(
                route("repuestos.destroy", id),
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

    const setRepuesto = (item = null) => {
        if (item) {
            oRepuesto.value.id = item.id;
            oRepuesto.value.nombre = item.nombre;
            oRepuesto.value._method = "PUT";
            return oRepuesto;
        }
        return false;
    };

    const limpiarRepuesto = () => {
        oRepuesto.value.id = 0;
        oRepuesto.value.nombre = "";
        oRepuesto.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oRepuesto,
        getRepuestos,
        getRepuestosApi,
        saveRepuesto,
        deleteRepuesto,
        setRepuesto,
        limpiarRepuesto,
    };
};
