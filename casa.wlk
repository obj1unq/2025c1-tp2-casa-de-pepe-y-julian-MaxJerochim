import cosas.* 

object casaDePepeYJulian {
    const listaDeCosas = []

    var property cuentaActual = cuentaCorriente

    method listaDeCosas() {
           return listaDeCosas
    }

    method comprar(cosa) {
          listaDeCosas.add(cosa)
          cuentaActual.extraer(cosa.precio())
    }

    method cantidadDeCosasCompradas() {
          return listaDeCosas.size()
    }
    
    method tieneAlgun(categoria) {
          return listaDeCosas.any({ cosa => cosa.esCategoria(categoria) })
    }

    method vieneDeComprar(categoria) {
          return self.compraronAlgunaCosa() && listaDeCosas.last().esCategoria(categoria)
    }

    method compraronAlgunaCosa() {
          return listaDeCosas.size() > 0
    }

    method esDerrochona() { 
          return self.importeTotal() >= 9000
    }

    method importeTotal() {
          return listaDeCosas.sum({ cosa => cosa.precio() })
    }

    method compraMasCara() {
          return listaDeCosas.filter({ cosa => self.esCosaMasCara(cosa) })
    }

    method esCosaMasCara(cosa) {
          return cosa.precio() == self.precioDeCompraMasCara()
    }

    method precioDeCompraMasCara() {
          return if (self.compraronAlgunaCosa()) {
               listaDeCosas.max({ cosa => cosa.precio() })
          } else {
               0
          }
    }
    
    method comprados(categoria) {
          return listaDeCosas.filter({ cosa => cosa.esCategoria(categoria) })
    }

    method malaEpoca() {
          return listaDeCosas.all({ cosa => cosa.esCategoria(comida) })
    }

    method queFaltaComprar(lista){
          return lista.filter({cosa => not self.seCompro(cosa)})
    }

    method seCompro(cosa) {
          return listaDeCosas.contains(cosa)
    }

    method faltaComida() {
          return self.cantidadDeComidaComprada() < 2
    }

    method cantidadDeComidaComprada() {
          return listaDeCosas.filter({ cosa => cosa.esCategoria(comida) }).size()
    }

    method categoriasCompradas(){
        return listaDeCosas.map({ cosa => cosa.categoria() }).asSet()
    }
}

object cuentaCorriente {

    var saldo = 20 // Inicializado con 20, pero es posible modificarlo con "depositar(cantidad)".

    method saldo() {
        return saldo
    }

    method depositar(cantidad) {
        saldo += cantidad
    }

    method extraer(cantidad) {
        self.validarSiPuedeExtraer(cantidad)
        saldo -= cantidad
    }

    method validarSiPuedeExtraer(cantidad) {
        if (self.saldo() < cantidad) {
            self.error("No hay suficiente plata en la cuenta.")
        }
    }
}

object cuentaConGastos {

    var property costoPorOperacion = 20
    var saldo = 500 // Inicializado con 500, pero es posible modificarlo con "depositar(cantidad)", aunque no más de 1000 por depósito.

    method saldo() {
        return saldo
    }

    method depositar(cantidad) {
        self.validarSiPuedeDepositar(cantidad)
        saldo += cantidad - costoPorOperacion
    }

    method validarSiPuedeDepositar(cantidad) {
        if (cantidad > 1000) {
            self.error("No se puede depositar más de 1000 en un despósito.")
        }
    }

    method extraer(cantidad) {
        saldo -= cantidad
    }
}