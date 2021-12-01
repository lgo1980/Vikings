class Expediciones {

	const vikingosIncorporados = []
	var property lugaresDestinos = []

	method incorporarVikingos(vikingos) {
		vikingosIncorporados.addAll(vikingos)
	}

	method incorporarLugares(lugares) {
		lugaresDestinos.addAll(lugares)
	}

	method subirVikingo(vikingo) {
		if (!vikingo.puedeSubirAUnaExpedicion()) throw new Exception(message = "El vikingo ingresado no puede subir a la expedicion")
		self.incorporarVikingos([ vikingo ])
	}

	method valeLaPena() = lugaresDestinos.all{ lugar => lugar.valeLaPena(vikingosIncorporados) }

	method realizarExpedicion() = lugaresDestinos.forEach{ lugar => lugar.invadir(vikingosIncorporados) }

}

class Vikingos {

	var property casta
	const armasObtenidas = []
	var vidasCobradas = 20
	var botinAcumulado = 0

	method cobrarUnaVida() {
		vidasCobradas += 1
	}

	method sumarAlBotin(suma) {
		botinAcumulado += suma
	}

	method botinAcumulado() = botinAcumulado

	method vidasCobradas() = vidasCobradas

	method agregarArmas(armas) {
		armasObtenidas.addAll(armas)
	}

	method puedeSubirAUnaExpedicion() = casta.esProductivo(armasObtenidas) && self.esProductivo()

	method esProductivo()

	method escalarSocialmente() {
		self.casta(casta.escalar())
	}

}

class Soldado inherits Vikingos {

	override method esProductivo() = vidasCobradas > 20 && !armasObtenidas.isEmpty()

}

class Granjero inherits Vikingos {

	var property cantidadHijos = 0
	var property cantidadDeHectarias = 0

	override method esProductivo() = cantidadDeHectarias > (cantidadHijos * 2)

}

class Casta {

	method esProductivo(armasObtenidas) = true

	method escalar() = thrall

}

object jarl inherits Casta {

	override method esProductivo(armasObtenidas) = armasObtenidas.isEmpty()

	override method escalar() = karl

}

object karl inherits Casta {

	override method escalar() = thrall

}

object thrall inherits Casta {

}

class LugarDestino {

	method botin()

	method valeLaPena(vikingosIncorporados) = self.botin()

	method invadir(vikingosIncorporados) {
		vikingosIncorporados.forEach{ vikingo => vikingo.sumarAlBotin(self.botin().div(vikingosIncorporados.size()))}
	}

}

class Capital inherits LugarDestino {

	var property defensoresDerrotados = 34

	method minimoBotin(vikingosIncorporados) = vikingosIncorporados.size() * 3

	override method valeLaPena(vikingosIncorporados) = super(vikingosIncorporados) >= self.minimoBotin(vikingosIncorporados)

	override method invadir(vikingosIncorporados) {
		super(vikingosIncorporados)
		vikingosIncorporados.forEach{ vikingo => vikingo.cobrarUnaVida()}
	}

	override method botin() = defensoresDerrotados

}

class Aldea inherits LugarDestino {

	var property totalDeCrucifijos = 37
	const minimoBotin = 15

	override method valeLaPena(vikingosIncorporados) = super(vikingosIncorporados) >= minimoBotin

	override method botin() = totalDeCrucifijos

}

class AldeaAmurallada inherits Aldea {

	var property cantidadMinimaVikingos = 3

	override method valeLaPena(vikingosIncorporados) = super(vikingosIncorporados) && self.tieneCantidadMinimaDeVikingos(vikingosIncorporados)

	method tieneCantidadMinimaDeVikingos(vikingosIncorporados) = vikingosIncorporados.size() >= cantidadMinimaVikingos

}

/*
 * Se crea una clase Castillo que herede de LugarDestino
 * class Castillo inherits LugarDestino {

 * 	aca irian las atributos y metodos necesarios

 * 	se sobreescriben los metodos necesarios para que funcione el polimorfismo 
 * 	override method valeLaPena(vikingosIncorporados) = devuelve si vale la pena segun criteria que se le asigne

 * 	override method botin() = devuelve el botin que se especifique

 * }
 */
 
