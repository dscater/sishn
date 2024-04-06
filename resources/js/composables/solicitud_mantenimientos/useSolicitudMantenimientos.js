import { useForm } from "@inertiajs/vue3";
import axios from "axios";
import { onMounted, ref, reactive } from "vue";
import { usePage } from "@inertiajs/vue3";

const oSolicitudMantenimiento = reactive({
    id: 0,
    codigo: "",
    responsable_id: null,
    nombre_responsable: "",
    ci_responsable: "",
    tecnico_id: null,
    nombre_tecnico: "",
    ci_tecnico: "",
    tipo_mantenimiento: null,
    motivo_mantenimiento: "",
    diagnostico: "",
    otros: "",
    fecha_solicitud: "",
    fecha_entrega: "",
    biometrico_id: "",
    array_repuestos: [],
    repuestos: null,
    cronogramas: reactive([]),
    eliminados: reactive([]),
    _method: "POST",
});

const oCronograma = ref({
    id: "",
    solicitud_mantenimiento_id: "",
    descripcion: "",
    date: "",
    user_id: "",
    backgrounColor: "",
});

export const useSolicitudMantenimientos = () => {
    const { flash } = usePage().props;
    const getSolicitudMantenimientos = async (
        order = "",
        sin_servicio = false,
        id = null
    ) => {
        try {
            const response = await axios.get(
                route("solicitud_mantenimientos.listado"),
                {
                    headers: { Accept: "application/json" },
                    params: {
                        order: order,
                        sin_servicio,
                        id,
                    },
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

    const getSolicitudMantenimientoById = async (id, params = {}) => {
        try {
            const response = await axios.get(
                route("solicitud_mantenimientos.getById", id),
                {
                    headers: { Accept: "application/json" },
                    params,
                }
            );
            return response.data.solicitud_mantenimiento;
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

    const getSolicitudMantenimientoByUnidadAreaId = async (
        id,
        order = "asc"
    ) => {
        try {
            const response = await axios.get(
                route("solicitud_mantenimientos.getByUnidadAreaId"),
                {
                    headers: { Accept: "application/json" },
                    params: {
                        unidad_area_id: id,
                        order,
                    },
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
            oSolicitudMantenimiento.id = item.id;
            oSolicitudMantenimiento.codigo = item.codigo;
            oSolicitudMantenimiento.responsable_id = item.responsable_id;
            oSolicitudMantenimiento.nombre_responsable =
                item.nombre_responsable;
            oSolicitudMantenimiento.ci_responsable = item.ci_responsable;
            oSolicitudMantenimiento.tecnico_id = item.tecnico_id;
            oSolicitudMantenimiento.nombre_tecnico = item.nombre_tecnico;
            oSolicitudMantenimiento.ci_tecnico = item.ci_tecnico;
            oSolicitudMantenimiento.tipo_mantenimiento =
                item.tipo_mantenimiento;
            oSolicitudMantenimiento.motivo_mantenimiento =
                item.motivo_mantenimiento;
            oSolicitudMantenimiento.diagnostico = item.diagnostico;
            oSolicitudMantenimiento.otros = item.otros;
            oSolicitudMantenimiento.fecha_solicitud = item.fecha_solicitud;
            oSolicitudMantenimiento.fecha_entrega = item.fecha_entrega;
            oSolicitudMantenimiento.biometrico_id = item.biometrico_id;
            oSolicitudMantenimiento.array_repuestos =
                item.array_repuestos.map(Number);
            oSolicitudMantenimiento.repuestos = item.repuestos;
            oSolicitudMantenimiento.cronogramas = reactive(item.cronogramas);
            oSolicitudMantenimiento.eliminados = reactive([]);
            oSolicitudMantenimiento._method = "PUT";
            return oSolicitudMantenimiento;
        }
        return false;
    };

    const limpiarSolicitudMantenimiento = () => {
        oSolicitudMantenimiento.id = 0;
        oSolicitudMantenimiento.codigo = "";
        oSolicitudMantenimiento.responsable_id = null;
        oSolicitudMantenimiento.nombre_responsable = "";
        oSolicitudMantenimiento.ci_responsable = "";
        oSolicitudMantenimiento.tecnico_id = null;
        oSolicitudMantenimiento.nombre_tecnico = "";
        oSolicitudMantenimiento.ci_tecnico = "";
        oSolicitudMantenimiento.tipo_mantenimiento = null;
        oSolicitudMantenimiento.motivo_mantenimiento = "";
        oSolicitudMantenimiento.diagnostico = "";
        oSolicitudMantenimiento.otros = "";
        oSolicitudMantenimiento.fecha_solicitud = "";
        oSolicitudMantenimiento.fecha_entrega = "";
        oSolicitudMantenimiento.biometrico_id = "";
        oSolicitudMantenimiento.array_repuestos = [];
        oSolicitudMantenimiento.repuestos = null;
        oSolicitudMantenimiento.cronogramas = reactive([]);
        oSolicitudMantenimiento.eliminados = reactive([]);
        oSolicitudMantenimiento._method = "POST";
    };

    const setCronograma = (item = null) => {
        if (item) {
            oCronograma.value.id = item.id;
            oCronograma.value.solicitud_mantenimiento_id =
                item.solicitud_mantenimiento_id;
            oCronograma.value.descripcion = item.descripcion;
            oCronograma.value.date = item.date;
            oCronograma.value.user_id = item.user_id;
            return oSolicitudMantenimiento;
        }
        return false;
    };

    const limpiarCronograma = () => {
        oCronograma.value.id = 0;
        oCronograma.value.solicitud_mantenimiento_id = "";
        oCronograma.value.descripcion = "";
        oCronograma.value.date = "";
        oCronograma.value.user_id = "";
    };

    onMounted(() => {});

    return {
        oSolicitudMantenimiento,
        oCronograma,
        getSolicitudMantenimientos,
        getSolicitudMantenimientosApi,
        getSolicitudMantenimientoById,
        getSolicitudMantenimientoByUnidadAreaId,
        saveSolicitudMantenimiento,
        deleteSolicitudMantenimiento,
        setSolicitudMantenimiento,
        limpiarSolicitudMantenimiento,
        limpiarCronograma,
    };
};
