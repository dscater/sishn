import { useForm } from "@inertiajs/vue3";
import axios from "axios";
import { onMounted, reactive } from "vue";
import { usePage } from "@inertiajs/vue3";

const oServicio = reactive({
    id: 0,
    solicitud_mantenimiento_id: null,
    fecha_entrega: "",
    procedimientos: "",
    observaciones: "",
    recomendaciones: "",
    diagnostico_previo: "",
    estado_equipo: "",
    trabajo_realizado: "",
    capacitacion: "NO",
    descripcion: "",
    fecha_ini: "",
    fecha_fin: "",
    array_repuestos: [],
    repuestos: null,
    _method: "POST",
});

export const useServicios = () => {
    const { flash } = usePage().props;
    const getServicios = async () => {
        try {
            const response = await axios.get(route("servicios.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.servicios;
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

    const getServiciosApi = async (data) => {
        try {
            const response = await axios.get(
                route("servicios.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.servicios;
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
    const saveServicio = async (data) => {
        try {
            const response = await axios.post(route("servicios.store", data), {
                headers: { Accept: "application/json" },
            });
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

    const deleteServicio = async (id) => {
        try {
            const response = await axios.delete(
                route("servicios.destroy", id),
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

    const setServicio = (item = null) => {
        if (item) {
            oServicio.id = item.id;
            oServicio.solicitud_mantenimiento_id =
                item.solicitud_mantenimiento_id;
            oServicio.fecha_entrega = item.fecha_entrega;
            oServicio.procedimientos = item.procedimientos;
            oServicio.observaciones = item.observaciones;
            oServicio.recomendaciones = item.recomendaciones;
            oServicio.diagnostico_previo = item.diagnostico_previo;
            oServicio.estado_equipo = item.estado_equipo;
            oServicio.trabajo_realizado = item.trabajo_realizado;
            oServicio.capacitacion = item.capacitacion;
            oServicio.descripcion = item.descripcion;
            oServicio.array_repuestos = item.array_repuestos.map(Number);
            oServicio.repuestos = item.repuestos;
            oServicio.fecha_ini = item.fecha_ini;
            oServicio.fecha_fin = item.fecha_fin;
            oServicio._method = "PUT";
            return oServicio;
        }
        return false;
    };

    const limpiarServicio = () => {
        oServicio.id = 0;
        oServicio.solicitud_mantenimiento_id = null;
        oServicio.fecha_entrega = "";
        oServicio.procedimientos = "";
        oServicio.observaciones = "";
        oServicio.recomendaciones = "";
        oServicio.diagnostico_previo = "";
        oServicio.estado_equipo = "";
        oServicio.trabajo_realizado = "";
        oServicio.capacitacion = "NO";
        oServicio.descripcion = "";
        oServicio.array_repuestos = [];
        oServicio.repuestos = null;
        oServicio.fecha_ini = "";
        oServicio.fecha_fin = "";
        oServicio._method = "POST";
    };

    onMounted(() => {});

    return {
        oServicio,
        getServicios,
        getServiciosApi,
        saveServicio,
        deleteServicio,
        setServicio,
        limpiarServicio,
    };
};
