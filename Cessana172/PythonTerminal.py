import os
import math
manche = 0
v_stall = 80
v_max = 226
velocidade = int(226*math.sqrt(manche/100))
airspeed = velocidade/1.852
altitude = 0
mistura = 0
peso = int(100*9.81)
def qfp(speed, alt, nos, pes):
	os.system("clear")
	ns = round(speed/1.852)
	title = "  Velocidade      Altitude         Velocidade do Ar          "
	string_t = f"   {speed}  Km/h              {alt}                    {ns} Km/h     {pes} N"
	print(title)
	print(string_t)
fest = input(" Desativar freio de estacionamento? [Y/N]:")
stats_fest = True
if fest == "Y":
	stats_fest = False
else:
	stats_fest = True
while stats_fest == False:
	qfp(velocidade, altitude, airspeed, peso)
	combustivel = 100
	for i in range(combustivel-100):
		combustivel -= 1
	print(f"   Combustivel: {combustivel}% ")
	mant = int(input(f"  Aumentar/diminuir manete[{manche}%]: "))
	manche = mant
	velocidade = int(226*math.sqrt(manche/100))
	if mant >= 10:
		altitude = mant*42
	while mant > 100:
		mant -= mant
		print("  Aviso:  O limite é 100%")
		mant = int(input(f"  Aumentar/diminuir manete[{mant}%]: "))
		if mant > 100:
			os.system("exit")