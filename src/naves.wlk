class NaveEspacial {
	var property velocidad = 0
	var property direccion = 0	
	
	method velocidad(cuanto) { velocidad = cuanto }
	method acelerar(cuanto) { velocidad = (velocidad + cuanto).min(100000) }
	method desacelerar(cuanto) { velocidad -= cuanto; velocidad=velocidad.max(0) }
	
	method irHaciaElSol() { direccion = 10 }
	method escaparDelSol() { direccion = -10 }
	method ponerseParaleloAlSol() { direccion = 0 }
	
	method acercarseUnPocoAlSol() { direccion += 1; direccion = direccion.min(10) }
	method alejarseUnPocoDelSol() { direccion -= 1; direccion = direccion.max(-10)}
	
}

class NavesBaliza inherits NaveEspacial {
	var property color
	
	method cambiarColorDeBaliza(colorNuevo){ color = colorNuevo }
	
	method prepararViaje(){ self.cambiarColorDeBaliza("verde"); self.ponerseParaleloAlSol() }
	
}

class NavesDePasajeros inherits NaveEspacial {
	var property cantidad
	var property comida
	var property bebida
	
	method cargar(tipo, cuanto){  if (tipo == comida){ comida +=cuanto }else{ bebida +=cuanto }}
	method descargar(tipo, cuanto){  if (tipo == comida){ comida -=cuanto }else{ bebida -=cuanto }}
	
	method prepararViaje(){ self.cargar(comida, 4); self.cargar(bebida, 6); self.acercarseUnPocoAlSol() }
}


class NavesDeCombate inherits NaveEspacial{
	
	var property visible = false
	var property misilesDesplegados = false
	var mensajes = []
	
	method ponerseVisible(){ visible = true }
	method ponerseInvisible(){ visible = false }
	method estaInvisible(){ return not visible }
	
	method desplegarMisiles(){ misilesDesplegados = true}
	method replegarMisiles(){ misilesDesplegados = false}
	method misilesDesplegados(){ return misilesDesplegados }
	
	method emitirMensaje(mensaje){ mensajes.add(mensaje) }
	method mensajesEmitidos(){ return mensajes.asList() }
	method primerMensajeEmitido(){ return mensajes.first() }
	method ultimoMensajeEmitido(){ return mensajes.last() }
	method esEscueta(){ return mensajes.all({m=> m.size() > 30 })}
	method emitioMensaje(mensaje){ mensajes.any({m => m == mensaje})}
	
	method prepararViaje(){ self.ponerseVisible(); self.replegarMisiles(); self.velocidad(15000); self.emitirMensaje("Saliendo en misión") }
	
}