# Sniper Elite HeadShot KillCam
A lame representation of the popular headshot killcam of the Sniper Elite franchise.

**[ENGLISH]**

**How to use?**

Open the SEKCdere.pwn file and find the following:

```
#define ALL_PLAYERS_KC
#define RANGE_KC
#define USE_STREAMER
```

Although their names can give you a hint, i'll explain what each one of these settings do:

`ALL_PLAYERS_KC` You can choose if you want only the involved players (who shot and who receive the bullet) to see the animation or if you want to display the killcam for players in the near range of the event. Default value is 0, which means only the involved players will be able to see the killcam. You can set this to 1 if you want the nearest players to see the killcam aswell

`RANGE_KC` This value is the range where the event occurs. The center of the point is the player who shoots. Default is 150. There's no MAX limit set for this, you can input whatever value you want here.

`USE_STREAMER` Define if you want to use Icognito's Streamer for the object creation (1 object per event) or use the default SA-MP natives. Default is 0, which means the Streamer is not in use. Set this value to 1 if you want to use the streamer functions.

----------------------------------------------

**[ESPAÑOL]**

**¿Cómo usar?**

Abre el archivo SEKCdere.pwn y busca lo siguiente:

```
#define ALL_PLAYERS_KC
#define RANGE_KC
#define USE_STREAMER
```

Aunque sus nombres pueden darte una idea, explicaré que hace cada una de esas opciones:

`ALL_PLAYERS_KC` Puedes elegir entre si mostrar la killcam sólo a los personajes involucrados (el que dispara y el que recibe el disparo) o si mostrar la killcam a un rango de personajes en el área cercana. El valor por defecto es 0, que significa que sólo los personajes involucrados verán la killcam. Puedes cambiar este valor a 1 para mostrar la killcam a los personajes dentro del área.

`RANGE_KC` Este es el valor en rango donde ocurre el evento. El centro del punto es el personaje que dispara. El valor por defecto es 150. No hay un limite máximo, puedes elegir el valor que desees aqui.

`USE_STREAMER` Define si deseas usar el Streamer de Icognito para la creacion del objeto (es 1 objeto por evento) o usar las funciones nativas de SA-MP. El valor por defecto es 0, que significa que el Streamer no está en uso. Cambia este valor a 1 para usar las funciones del streamer de Icognito.
