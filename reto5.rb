=begin
  1. Bienvenida y explicación al jugador
  2. Mostrar una definición al jugador (previamente debe colocar el título "Definición")
  3. Habilitar un campo para recibir la respuesta (Este campo debe tener previamente el mensaje "Adivinar")
  4. Evaluar si el mensaje es igual a la respuesta de la definición
     4.1 Si la respuesta es incorrecta, colocar el mensaje "Incorrecto!, Trata de nuevo" y volver al punto 3
     4.2 Si la respuesta es correcta, colocar el mensaje "Correcto!" y pasar al punto 2.

  5. Hacer este ciclo 5 veces 
=end

=begin
  1. Cómo representar el juego
  2. Cómo representar el puntaje
  3. Cómo representar las preguntas y sus respuestas
  4. Cómo representar las preguntas que ya se realizarón y las preguntas por hacer
=end
class Questionary
  attr_reader :file

  def initialize(file)
    @question_list = []
    @file = file  
    read  
  end  
  
  def take!
    @question_list.shift.strip.upcase # sacar el primer elemento de un array y el método strip para limpiar "\n"
  end
  
  private
  def read
    if File.exist?(@file)      
      @question_list = IO.readlines(@file)      
    else
      nil
      puts "El archivo de las preguntas no existe"
    end
  end

end

class ReadLine
   

  def initialize (questionary)
    @questionary = questionary
    @question_answer_list = []
  end
  
  def hit!
    @question_answer_list.push(@questionary.take!)   
  end
end

# source https://gist.github.com/ikenna/6422329
class Stopwatch 
 
  def initialize()
    @start = Time.now
  end
   
  def elapsed_time
    now = Time.now
    elapsed = now - @start
  end
   
end

questionary = Questionary.new('q.txt')
read_line = ReadLine.new(questionary)
s = Stopwatch.new
limit_time = 60


puts "Bienvenido a reto 5, Para jugar, solo ingresa el termino correcto para cada una de las definiciones, Listo? Vamos!"
puts "El cuestionario es de 5 preguntas, para ganar debes contestarlas antes de 60 segundos"
puts "Sin embargo el juego no se interrumpe si superas los 60 segundos"

val = 0;
cicles = 5
cicles.times do |i|
  puts
  val += 1
  puts "#{val} Definición:"
  print " #{read_line.hit!.last}"
  puts
  print " Adivinar: "
  answer = gets.chomp.upcase 
  ultimo = read_line.hit!.last

  while answer != ultimo
    puts "Incorrecto!, Trata de nuevo"
    print " Adivinar: "
    answer = gets.chomp.upcase
  end
  puts "Correcto!"
end

puts
if (s.elapsed_time.to_i <= limit_time) && (cicles == val)
  puts "Ganaste, respondiste todas las preguntas y tu tiempo fue de #{s.elapsed_time.round(1)} segundos / #{limit_time} segundos"
else
  puts "Perdiste, el tiempo limite es #{limit_time} segundos y utilizaste  #{s.elapsed_time.round(1)} segundos"  
end  











