import wollok.game.*

object mercados {
	
	var property mercados = #{}
		
	method agregar(position, oro) {
		const mercado = new Mercado(position=position, oro=oro)
		mercados.add(mercado)
		game.addVisual(mercado)
	}
	
	method mercado(position) {
		return mercados.findOrElse({mercado => mercado.position() == position}, {self.error("No Hay mercado aquí")})	
	}
	
	method comprar(granjero) {
		self.mercado(granjero.position()).comprar(granjero)
	}
}


class Mercado {
	const property position
	var property oro
	const property mercaderias = #{}
	
	method text() {
		return "oro: " + oro + " mercaderías: " + mercaderias.size()	
	}
	 
	method image() {return "market.png"}
	
	method validarComprar(granjero) {
		if (oro < granjero.precioCosecha()) {
			self.error("No puedo pagar " + granjero.precioCosecha())
		}
	}
	
	method comprar(granjero) {
		self.validarComprar(granjero)
		oro = oro - granjero.precioCosecha()
		mercaderias.addAll(granjero.cosechados())
	}
	
}
