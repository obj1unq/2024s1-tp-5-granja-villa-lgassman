import wollok.game.*
import cultivos.*
import aspersores.*
import mercados.*

object granja {
	
	const property sembrados = #{}
	
	method agregarCultivo(cultivo) {
		sembrados.add(cultivo)
	} 
	
	method sembrados(position) {
		return sembrados.filter({cultivo => cultivo.position() == position})
	}
}

object hector {
	var property position = game.center()
	const property image = "player.png"
	var property cosechados = #{}
	var oro = 0
	var property plantacion = granja
	var property comprador = mercados
	
	method descripcion() {
		return "tengo $" + oro + " y " + cosechados.size() + " plantas"
	}
	
	method agregarAspersor() {
		aspersores.crear(position, plantacion)
	}
	
	method sembrar(cultivo) {
		cultivo.position(position)
		plantacion.agregarCultivo(cultivo)
		game.addVisual(cultivo)
	}
	
	method regar() {
		self.cultivos().forEach({cultivo => cultivo.regar()})
	}
	
	method cosechar() {
		self.cultivosCosechables().forEach({cultivo => self.cosechar(cultivo)})
	}
	
	method cosechar(cultivo) {
		cosechados.add(cultivo)
		game.removeVisual(cultivo)
	}
	
	method cultivosCosechables() {
		const cosechables = self.cultivos().filter({cultivo => cultivo.cosechable()})
		if (cosechables.isEmpty()) {
			self.error("No hay cultivos cosechables acá")
		}
		return cosechables
	}
	
	method cultivos() {
		const cultivos = plantacion.sembrados(position)
		if (cultivos.isEmpty()) {
			self.error("No hay cultivos acá")
		}
		return cultivos
	}
	
	method validarVender() {
		if (cosechados.isEmpty()) {
			self.error("No hay nada que vender")
		}
	}
	
	method vender() {
		self.validarVender()
		comprador.comprar(self)
		oro += self.precioCosecha()
		cosechados.clear()
	}
	
	method precioCosecha() {
		return cosechados.sum({cultivo => cultivo.precio()})
	}
	
}