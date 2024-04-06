<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('institucions', function (Blueprint $table) {
            $table->id();
            $table->string("nombre", 255);
            $table->string("nombre_sistema", 255);
            $table->string("nit", 255);
            $table->text("historia", 255)->nullable();
            $table->text("mision", 255)->nullable();
            $table->text("vision", 255)->nullable();
            $table->text("objetivo", 255)->nullable();
            $table->string("nombre_director", 255);
            $table->string("foto_director", 255)->nullable();
            $table->string("nombre_subdirector", 255)->nullable();
            $table->string("foto_subdirector", 255)->nullable();
            $table->string("fono1", 255)->nullable();
            $table->string("fono2", 255)->nullable();
            $table->string("correo1", 255)->nullable();
            $table->string("correo2", 255)->nullable();
            $table->string("facebook", 255)->nullable();
            $table->string("youtube", 255)->nullable();
            $table->string("twitter", 255)->nullable();
            $table->string("dir", 255);
            $table->text("ubicacion_google")->nullable();
            $table->string("img_organigrama")->nullable();
            $table->string("logo")->nullable();
            $table->string("logo2")->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('institucions');
    }
};
