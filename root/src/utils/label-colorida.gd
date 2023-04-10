extends RichTextLabel
#LABEL
var count = 0.0
var cor_anterior
var cor_atual
const tempo = .5

var color_array = [Color(.39,.68,.21),Color(1,1,.32),
Color(.98,.6,.07),Color(1,.15,.07),Color(.51,0,.65),
Color(.07,.27,.98)]
var array_index = 0

		
func _process(delta):
	count += delta
	if count > tempo:
		array_index += 1
		count = 0
	if array_index > (color_array.size() - 1): array_index = 0
	cor_atual = Color(color_array[array_index])
	cor_anterior = self.get_modulate()
	self.set_modulate(Color(cor_anterior.linear_interpolate(cor_atual, count)))
