import os
import math
import time
import requests

req = requests.get("http://ip-api.com/json/")
dados = req.json()

cidade = dados['city']
estado = dados['region']

print("   Carregando servidor..")
print(f"  Iniciando voo em: Aeroporto de {cidade}/{estado}")

manche = 0
v_stall = 80
v_max = 226
combustivel = int(100)
inc = 0

velocidade = int(226*math.sqrt(manche/100))
airspeed = velocidade/1.852
g_inc = int(math.pow(velocidade, 2)/9.88*math.tan(inc))
raio_curva = math.pow(velocidade, 2)/1

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
	combustivel = int(combustivel-0.001)
	RPM = int((velocidade/1.5)*60)
	print("")
	print("   Modelo: Cessana 172")
	print(f"   Combustivel: {combustivel}% ")
	print(f"   Inclinação: {inc}°")
	print(f"   RPM: {RPM}")
	print("")
	if combustivel <= 0:
		print("Aviso: O COMBUSTIVEL ACABOU.")
		os.system("exit")
	mant = int(input(f"  Aumentar/diminuir manete[{manche}%]: "))
	inclinacao = int(input(f"   Aumentar/diminuir inclinação[{inc}%]: "))
	
	inc = inclinacao
	manche = mant
	velocidade = int(226*math.sqrt(manche/100))
	if mant <= 0:
		stats_fest = input("  Ativar freio de estacionamento? [Y/N]: ")
	if stats_fest == "Y":
		print("")
		print("  Aviso: VOO CONCLUIDO COM SUCESSO")
	if mant >= 10:
		altitude = mant*42
	while mant > 100:
		mant -= mant
		print("  Aviso:  O limite é 100%")
		mant = int(input(f"  Aumentar/diminuir manete[{mant}%]: "))
		if mant > 100:
			os.system("exit")