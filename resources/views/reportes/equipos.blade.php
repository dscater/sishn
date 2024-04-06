<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Solicitud de Mantenimiento</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1cm;
            margin-bottom: 1cm;
            margin-left: 1.5cm;
            margin-right: 1cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: 40px;
            page-break-before: avoid;
        }

        table thead tr th,
        tbody tr td {
            padding: 3px;
            word-wrap: break-word;
        }

        table thead tr th {
            font-size: 9pt;
        }

        table tbody tr td {
            font-size: 7pt;
        }


        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            height: 90px;
            top: -20px;
            left: 20px;
        }

        .logo2 img {
            position: absolute;
            height: 90px;
            top: -20px;
            right: 20px;
        }

        .qr img {
            position: absolute;
            height: 90px;
            top: -20px;
            right: 20px;
        }

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 0PX;
            margin-bottom: 15px;
            text-align: center;
            font-size: 14pt;
        }

        .texto {
            width: 400px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: bold;
            font-size: 1em;
        }

        .fecha {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: normal;
            font-size: 0.85em;
        }

        table {
            width: 100%;
        }

        table thead {
            background: rgb(236, 236, 236)
        }

        tr {
            page-break-inside: avoid !important;
        }

        .centreado {
            padding-left: 0px;
            text-align: center;
        }

        .datos {
            margin-left: 15px;
            border-top: solid 1px;
            border-collapse: collapse;
            width: 250px;
        }

        .txt {
            font-weight: bold;
            text-align: right;
            padding-right: 5px;
        }

        .bold {
            font-weight: bold;
        }

        .txt_center {
            font-weight: bold;
            text-align: center;
        }

        .cumplimiento {
            position: absolute;
            width: 150px;
            right: 0px;
            top: 86px;
        }

        .b_top {
            border-top: solid 1px black;
        }

        .gray {
            background: rgb(202, 202, 202);
        }

        .bg-principal {
            background: #c57a40;
            color: white;
        }

        .img_celda img {
            width: 45px;
        }

        .break_page {
            page-break-after: always;
        }

        .border_top {
            border-top: solid 1px black;
        }

        .border_bot {
            border-bottom: solid 1px black;
        }

        .padding_top {
            padding-top: 6px;
        }

        .padding_bot {
            padding-bottom: 6px;
        }

        td.foto img {
            width: 40px;
        }
    </style>
</head>

<body>
    @inject('institucion', 'App\Models\Institucion')
    @php
        $cont = 0;
    @endphp
    @foreach ($unidad_areas as $ua)
        <div class="encabezado">
            <div class="logo">
                <img src="{{ $institucion->first()->url_logo }}">
            </div>
            <div class="logo2">
                <img src="{{ $institucion->first()->url_logo2 }}">
            </div>
            <h2 class="titulo">
                {{ $institucion->first()->nombre }}
            </h2>
            <h4 class="texto">LISTA DE EQUIPOS BIOMÉTRICOS</h4>
        </div>

        <table border="1">
            <thead>
                <tr>
                    <th colspan="9">{{ $ua->nombre }}</th>
                </tr>
                <tr>
                    <th width="5%">N°</th>
                    <th>NOMBRE</th>
                    <th width="14%">EQUIPO</th>
                    <th>FECHA INGRESO</th>
                    <th>GARANTÍA</th>
                    <th>CÓDIGO H.D.N.</th>
                    <th>EMPRESA</th>
                    <th>IMAGEN</th>
                    <th>FECHA REGISTRO</th>
                </tr>
            </thead>
            <tbody>
                @php
                    $nro_reg = 1;
                @endphp
                @foreach ($ua->biometricos as $biometrico)
                    <tr>
                        <td class="centreado">{{ $nro_reg++ }}</td>
                        <td>{{ $biometrico->nombre }}</td>
                        <td>
                            MARCA: {{ $biometrico->marca }};<br />
                            MODELO: {{ $biometrico->marca }};<br />
                            SN: {{ $biometrico->marca }}<br />
                        </td>
                        <td>{{ $biometrico->fecha_ingreso_t }}</td>
                        <td>{{ $biometrico->garantia }}</td>
                        <td>{{ $biometrico->cod_hdn }}</td>
                        <td>{{ $biometrico->empresa ? $biometrico->empresa->nombre : '' }}</td>
                        <td class="centreado foto">
                            @if ($biometrico->url_foto)
                                <img src="{{ $biometrico->url_foto }}" alt="">
                            @else
                                S/I
                            @endif
                        </td>
                        <td>{{ $biometrico->fecha_registro_t }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>
        @php
            $cont++;
        @endphp
        @if ($cont < count($unidad_areas))
            <div class="break_page"></div>
        @endif
    @endforeach
</body>

</html>
