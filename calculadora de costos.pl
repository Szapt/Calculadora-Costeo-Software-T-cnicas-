% Calculadora de Costos de Desarrollo de Software

calculadora_costos :-
    writeln('Bienvenido a la CALCULADORA.'), 
    writeln(' '),

    writeln('Seleccione el tipo de proyecto:'),
    writeln('1. Proyecto pequeno'),
    writeln('   (Costo de Infraestructura: 458000 - Capitalizaion: 14% - Costo de Riesgos: 5%)'),
    writeln('2. Proyecto mediano'),
    writeln('   (Costo de Infraestructura: 1140000 - Capitalizaion: 15% - Costo de Riesgos: 10%)'),
    writeln('3. Proyecto grande'),
    writeln('   (Costo de Infraestructura: 1830000 - Capitalizaion: 16% - Costo de Riesgos: 15%)'),
    obtener_tipo_proyecto(TipoProyecto),

    obtener_horas('Ingrese las horas de desarrollo: ', HorasDesarrollo),
    obtener_horas_contador('Ingrese las horas que trabajara el contador: ', HorasContador),
    obtener_cantidad('Ingrese la cantidad de desarrolladores junior: ', Junior),
    obtener_cantidad('Ingrese la cantidad de desarrolladores senior: ', Senior),
    obtener_cantidad('Ingrese la cantidad de arquitectos de software: ', Arquitecto),

    definir_costos_miembros(CostoJunior, CostoSenior, CostoArquitecto),
    costo_contador(HorasContador, CostoContador),
    costo_por_miembro(Junior, Senior, Arquitecto, CostoJunior, CostoSenior, CostoArquitecto, HorasDesarrollo, CostoTotalMiembros),
    CostoAdministrativo is CostoTotalMiembros + CostoContador,

    gastos_infrastructura(TipoProyecto, CostoInfraestructura),
    porcentaje_capitalizacion(TipoProyecto, PorcentajeCapitalizacion),
    porcentaje_riesgos(TipoProyecto, PorcentajeRiesgos),

    CostoCasiTotal is CostoAdministrativo + CostoInfraestructura,
    CostoCapitalizacion is CostoCasiTotal * PorcentajeCapitalizacion,
    CostoRiesgos is CostoCasiTotal * PorcentajeRiesgos,

    CostoTotalSinImpuestos is CostoCasiTotal + CostoCapitalizacion + CostoRiesgos,

    % Calculo de impuestos
    calcular_impuestos(CostoTotalSinImpuestos, CostoImpuestos),

    % Suma de impuestos al costo total
    CostoTotal is CostoTotalSinImpuestos + CostoImpuestos,

    writeln(' '),
    writeln('----------------------------------------------'),
    format('Gastos de Infraestructura: ~2f~n', [CostoInfraestructura]),
    format('Gastos Administrativos: ~2f~n', [CostoAdministrativo]),
    format('Gastos de Riesgos: ~2f~n', [CostoRiesgos]),
    format('Gastos de Impuestos: ~2f~n', [CostoImpuestos]),
    writeln('----------------------------------------------'),
    format('Costo total del proyecto: ~2f~n', [CostoTotal]),
    writeln('----------------------------------------------').

% Predicado para obtener el tipo de proyecto
obtener_tipo_proyecto(TipoProyecto) :-
    writeln('Seleccione el tipo de proyecto:'),
    writeln('1. Proyecto pequeno'),
    writeln('   (Costo de Infraestructura: 458000 - Capitalizaion: 14% - Costo de Riesgos: 5%)'),
    writeln('2. Proyecto mediano'),
    writeln('   (Costo de Infraestructura: 1140000 - Capitalizaion: 15% - Costo de Riesgos: 10%)'),
    writeln('3. Proyecto grande'),
    writeln('   (Costo de Infraestructura: 1830000 - Capitalizaion: 16% - Costo de Riesgos: 15%)'),

    repeat,
    write('Ingrese el numero correspondiente al tipo de proyecto: '),
    read(Entrada),
    (   
        member(Entrada, [1, 2, 3]) -> 
            TipoProyecto = Entrada, % solo asigna el numero del tipo de proyecto
            !
        ;   
            writeln('Por favor, ingrese un numero valido (1, 2 o 3).'),
            fail % si la entrada no es valida, se repite el bucle
    ).

% Predicado para obtener gastos de infrastructura, incluye servidor en la nube y licencias necesarias
gastos_infrastructura(1, 458000).
gastos_infrastructura(2, 1140000).
gastos_infrastructura(3, 1830000).

% Predicado para obtener el porcentaje de capitalizacion segun el tipo de proyecto
porcentaje_capitalizacion(1, 0.14).
porcentaje_capitalizacion(2, 0.15).
porcentaje_capitalizacion(3, 0.16).

% Predicado para obtener el porcentaje de riesgos segun el tipo de proyecto
porcentaje_riesgos(1, 0.05).
porcentaje_riesgos(2, 0.10).
porcentaje_riesgos(3, 0.15).

% Predicado para obtener un costo validado (no permite valores negativos)
obtener_costo(Mensaje, Costo) :-
    repeat,
    write(Mensaje),
    read(Entrada),
    (   number(Entrada), Entrada >= 0 ->
            Costo is Entrada, % si la entrada es un numero no negativo, se asigna a Costo y se sale del bucle
            !
        ;
            writeln('Por favor, ingrese un valor numerico no negativo.'),
            fail % si la entrada no es un numero no negativo, se repite el bucle
    ).

% Predicado para obtener una cantidad validada (no permite valores negativos)
obtener_cantidad(Mensaje, Cantidad) :-
    repeat,
    write(Mensaje),
    read(Entrada),
    (   integer(Entrada), Entrada >= 0 ->
            Cantidad is Entrada, % si la entrada es un numero entero no negativo, se asigna a Cantidad y se sale del bucle
            !
        ;
            writeln('Por favor, ingrese una cantidad entera no negativa.'),
            fail % si la entrada no es un numero entero no negativo, se repite el bucle
    ).

% Predicado para obtener horas validadas (no permite valores negativos)
obtener_horas(Mensaje, Horas) :-
    repeat,
    write(Mensaje),
    read(Entrada),
    (   integer(Entrada), Entrada >= 0 ->
            Horas is Entrada, % si la entrada es un numero entero no negativo, se asigna a Horas y se sale del bucle
            !
        ;
            writeln('Por favor, ingrese un numero entero de horas no negativo.'),
            fail % si la entrada no es un numero entero no negativo, se repite el bucle
    ).

% Predicado para obtener horas validadas para el contador (no permite valores negativos)
obtener_horas_contador(Mensaje, Horas) :-
    repeat,
    write(Mensaje),
    read(Entrada),
    (   integer(Entrada), Entrada >= 0 ->
            Horas is Entrada, % si la entrada es un numero entero no negativo, se asigna a Horas y se sale del bucle
            !
        ;
            writeln('Por favor, ingrese un numero entero de horas para el contador no negativo.'),
            fail % si la entrada no es un numero entero no negativo, se repite el bucle
    ).

% Predicado para definir los costos por tipo de miembro del equipo
definir_costos_miembros(CostoJunior, CostoSenior, CostoArquitecto) :-
    CostoJunior = 14000,
    CostoSenior = 27000,
    CostoArquitecto = 39000.

% Predicado para calcular el costo total por miembro del equipo
costo_por_miembro(Junior, Senior, Arquitecto, CostoJunior, CostoSenior, CostoArquitecto, HorasDesarrollo, CostoTotalMiembros) :-
    CostoTotalMiembros is (Junior * CostoJunior * HorasDesarrollo) +
                          (Senior * CostoSenior * HorasDesarrollo) +
                          (Arquitecto * CostoArquitecto * HorasDesarrollo).

% Predicado para calcular el costo total del contador
costo_contador(HorasContador, CostoContador) :-
    TarifaContadorPorHora = 14000,
    CostoContador is HorasContador * TarifaContadorPorHora.

% Predicado para calcular impuestos
calcular_impuestos(CostoTotalSinImpuestos, CostoImpuestos) :-
    Iva is CostoTotalSinImpuestos * 0.19,
    ValorDespuesIva is CostoTotalSinImpuestos + Iva,
    
    ReteIca is ValorDespuesIva * 0.01,
    ValorDespuesReteIca is ValorDespuesIva + ReteIca,

    RetencionFuente is ValorDespuesReteIca * 0.11,

    CostoImpuestos is Iva + ReteIca + RetencionFuente.

