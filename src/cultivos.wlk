import wollok.game.*

class Maiz {
	
	var property position = null
	var estado = baby
	
	method image() {
		return "corn_" + estado + ".png"
	}
	
	method regar() {
		estado = adult
	}
	
	method cosechable() {
		return estado.cosechable()
	}
	
	method precio() {
		return 150
	}
		
}

object baby {
	method cosechable() {
		return false
	}
}

object adult {
	method cosechable() {
		return true
	}
}

class Trigo {
	
	var property position = null
	var etapa = 0
	const ultimaEtapa = 3
	
	method image() {
		return "wheat_" + etapa + ".png"
	}
	
	method regar() {
		etapa = if (etapa < ultimaEtapa) etapa + 1 else 0	
	}
	
	method cosechable() {
		return etapa >= 2
	}
	
	method precio() {
		return (etapa -1 ) * 100
	}
	
	
}

class Tomaco {
	
	var property position = null
	method image() {
		return "tomaco.png"
	}

	method regar() {
		position = game.at(position.x(), self.nextY())	
	}
	
	method nextY() {
		return if (game.height() - 1 != position.y()) position.y() + 1 else 0  
	}
	
	method cosechable() {
		return true
	}
	
	method precio() {
		return 80
	}

	
	
}

