
class NaveEspacial {
	var property velocidad = 0
	var property direccion = 0
	var property combustible = 0	
	
	method acelerar(cuanto) { velocidad = (velocidad + cuanto).min(100000) }
	method desacelerar(cuanto) { velocidad -= cuanto; velocidad = velocidad.max(0) }
	
	method irHaciaElSol() { direccion = 10 }
	method escaparDelSol() { direccion = -10 }
	method ponerseParaleloAlSol() { direccion = 0 }
	
	method acercarseUnPocoAlSol() { direccion += 1; direccion = direccion.min(10) }
	method alejarseUnPocoDelSol() { direccion -= 1; direccion = direccion.max(-10)}
	
	method cargarCombustible(litros){ combustible += litros}
	method descargarCombustible(litros){ combustible -= litros}
	
	method prepararViaje(){ self.cargarCombustible(30000); self.acelerar(5000) }
	
	method recibirAmenaza(){ self.escapar() self.avisar()}
	
	method escapar()
	method avisar()
	
	method estaTranquila(){ return combustible >= 4000 and velocidad <= 12000 }
}

class NavesBaliza inherits NaveEspacial {
	var property color
	
	method cambiarColorDeBaliza(colorNuevo){ color = colorNuevo }
	
	override method prepararViaje(){ super(); self.cambiarColorDeBaliza("verde"); self.ponerseParaleloAlSol() }
	
	override method escapar(){ self.irHaciaElSol() }
	override method avisar(){ self.cambiarColorDeBaliza("rojo") }
	
	override method estaTranquila(){ return super() and color != "rojo" }
}

class NavesDePasajeros inherits NaveEspacial {
	var property cantPasajeros
	var property comida
	var property bebida
	
	method cargar(tipo, cuanto){  if (tipo == comida){ comida +=cuanto }else{ bebida +=cuanto }}
	method descargar(tipo, cuanto){  if (tipo == comida){ comida -=cuanto }else{ bebida -=cuanto }}
	
	override method prepararViaje(){ super(); self.cargar(comida, 4 * cantPasajeros); self.cargar(bebida, 6 * cantPasajeros);
		 self.acercarseUnPocoAlSol()}
		 
	override method escapar(){ velocidad = velocidad * 2 }
	override method avisar(){ self.descargar(comida, cantPasajeros);self.descargar(bebida, cantPasajeros * 2) }
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
	method mensajesEmitidos(){ return mensajes }
	method primerMensajeEmitido(){ return mensajes.first() }
	method ultimoMensajeEmitido(){ return mensajes.last() }
	method esEscueta(){ return mensajes.all({m=> m.size() <= 30 })}
	method emitioMensaje(mensaje){ return mensajes.any({m => m == mensaje})}
	
	override method prepararViaje(){ super(); self.ponerseVisible(); self.replegarMisiles(); self.acelerar(15000);
		self.emitirMensaje("Saliendo en misión")}
	
	override method escapar(){ self.acercarseUnPocoAlSol() self.acercarseUnPocoAlSol() }
	override method avisar(){ self.emitirMensaje("Amenaza recibida") }
	
	override method estaTranquila(){ return super() and not misilesDesplegados }
}


class NaveHospital inherits NavesDePasajeros {
	var property quirofanosPreparados = false
	
	method prepararQuirofano(){ quirofanosPreparados = true }
	override method recibirAmenaza(){ super() self.prepararQuirofano()}
	
	override method estaTranquila(){ return super() and not quirofanosPreparados }
}


class NaveDeCombateSigilosa inherits NavesDeCombate {
	
	override method escapar(){ super()  self.desplegarMisiles()  self.ponerseInvisible() }
	override method estaTranquila(){ return super() and not misilesDesplegados and visible }
}

