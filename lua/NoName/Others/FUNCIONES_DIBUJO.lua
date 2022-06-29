

---- | TRIÁNGULOS |

function Ftriangulo(valor)
fig_triangulo = "m 0 0 l 0 0 l 30 50 l -30 50 l 0 0 "   -- EQUILATERO
if not valor or valor >=5 then
return fig_triangulo
    elseif valor == 1 then
    fig_triangulo2 = "m 0 0 l -10 30 l 10 30 l 0 0 "  -- ISÓSCELES
    return fig_triangulo2
        elseif valor ==2 then
        fig_triangulo3 = "m 0 0 l -10 -20 l 35 0 l 0 0 "  -- ESCALENO
        return fig_triangulo3
            elseif valor ==3 then
            fig_triangulo4 = "m 0 0 l 0 -25 l 25 0 l 0 0 "  -- RECTANGULO
            return fig_triangulo4
	            elseif valor ==4 then
				fig_triangulo5 = "m 0 0 l 0 0 l 30 0 l -10 -50 l 0 0 "  -- OBTUSÁNGULO
				return fig_triangulo5		
				    elseif valor ==5 then
					fig_triangulo6 = "m 0 0 l 15 -45 l 45 0 l 0 0 "  -- ACUTÁNGULO
					return fig_triangulo6				
end
end

---- | CUADRO |

function Fcuadro()
fig_cuadro = "m 0 0 l 0 -40 l 40 -40 l 40 0 l 0 0 "
return fig_cuadro
end

---- | RECTANGULO |

function Frectangulo()
fig_rectangulo = "m 0 0 l 0 0 l 60 0 l 60 -30 l 0 -30 l 0 0 "
return fig_rectangulo
end

---- | TRAPECIO |

function Ftrapecio()
fig_trapecio = "m 0 0 l 60 0 l 40 -20 l 20 -20 l 0 0 "
return fig_trapecio
end


---- | ROMBOIDE |

function Frombo()
fig_rombo = "m 0 0 l 0 0 l 60 0 l 80 -30 l 20 -30 l 0 0 "
return fig_rombo
end

---- | PENTAGONO |

function Fpentagono()
fig_penta = "m 0 0 l 26 0 l 39 -25 l 13 -49 l -13 -25 l 0 0 "
return fig_penta
end

---- | HEXAGONO |

function Fhexagono()
fig_hexa = "m 0 0 l 26 0 l 39 -25 l 13 -49 l -13 -25 l 0 0 "
return fig_hexa
end

---- | HEPTAGONO |

function Fheptagono()
fig_hepta = "m 0 0 l 21 0 l 36 -18 l 36 -37 l 10 -53 l -14 -37 l -14 -18 l 0 0 "
return fig_hepta
end

---- | OCTAGONO |

function Foctagono()
fig_octa = "m 0 0 l 20 0 l 35 -17 l 35 -34 l 20 -50 l 0 -50 l -14 -34 l -14 -17 l 0 0 "
return fig_octa
end











