import wollok.game.*

object aspersores {
	
	const todos = #{} 
	
	method crear(position, plantacion) {
		const aspersor = new Aspersor(position=position, plantacion=plantacion)
		todos.add(aspersor)
		game.addVisual(aspersor)
	}
	
	method activar() {
		todos.forEach({aspersor => aspersor.activar()})
	}
	
}

class Aspersor {
	
	const property position
	const plantacion
	
	method image() {return "aspersor.png"}
	
	method activar() {
		self.vecinos().forEach({_position => self.regar(_position)}) 
	}
	
	method vecinos() {
		//Esta es la forma más consisa de generar los vecinos. No es la 
		return (-1..1).map({deltaX => 
					(-1..1).map({ deltaY=>
						//Por un bug de wollok conviene pasar por constante x y y em lugar 
						//de hacer directamente el cálculo en la misma linea que el game.at
						const x = position.x() + deltaX
						const y = position.y() + deltaY
						return game.at(x,y)		
					})
			})
			.flatten() //Al anidar dos maps, el resultado es una lista de listas con las posiciones. El flatten deja una unica lista con todas las posiciones
			.filter({pos => pos != position}) //Quito el resultado cuando deltaX y deltaY son 0
	}
	
	method regar(_position) {
		plantacion.sembrados(_position).forEach({cultivo => cultivo.regar()})
	}
	
}
