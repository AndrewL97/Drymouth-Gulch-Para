//Holodisks stuff
//Here we get the basic mechanics as coded by WB! Praise him and other Unknown coder for this.

/obj/item/weapon/holodisk
	name = "holodisk"
	desc = "A durable laser-readable storage device produced by Wattz Electronics, based on the tape holography technology, storing their information safely for extended periods of time."
	icon = 'icons/obj/items.dmi'
	icon_state = "holodisk"
	item_state = "holodisk"
	throwforce = 0
	hitsound = null
	w_class = 1.0
	throw_speed = 3
	throw_range = 7
	attack_verb = list("Played holodisk")
	var/busy = 0
	var/soundLength = 50
	var/soundFile = 'sound/f13music/mysterious_stranger.ogg'

/obj/item/weapon/holodisk/New()
        src.name = "holodisk #[rand(1,999)]"
        return ..()

/obj/item/weapon/holodisk/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	src.playAudio(user)
	return ..()

/obj/item/weapon/holodisk/attack_self(mob/user as mob)
	src.playAudio(user)
	return

/obj/item/weapon/holodisk/proc/playAudio(mob/user)
	if(!src.busy)
		src.busy = 1
		playsound(get_turf(src),src.soundFile,50)
		src.add_fingerprint(user)
		src.icon_state = "[initial(src.icon_state)]anim"
		spawn(src.soundLength)
			src.icon_state = initial(src.icon_state)
			src.busy = 0
	return

//Here we get any holodisks we want, using the basic mechanics.

/obj/item/weapon/holodisk/holodiskabducted
	soundFile =  'sound/f13items/holodisk_abducted.ogg'
	soundLength = 430

//One special holodisk can gib the listener or cripple someone else.

/obj/item/weapon/holodisk/holodiskcursed
	soundFile =  'sound/f13items/holodisk_cursed.ogg'
	soundLength = 230
	throwforce = 50 //It's funny counting you can't give objects hand to hand on TG, but have to throw or drop them instead.

/obj/item/weapon/holodisk/holodiskcursed/playAudio(mob/user)
	if(!src.busy)
		src.busy = 1
		playsound(get_turf(src),src.soundFile,50)
		src.add_fingerprint(user)
		src.icon_state = "[initial(src.icon_state)]anim"
		spawn(src.soundLength)
			if(user) user.gib()
			src.icon_state = initial(src.icon_state)
			src.busy = 0

	return

/datum/martial_art/patraining
	name = "Power Armor Training"

/obj/item/weapon/holodisk/powerarmor
	desc = "A durable laser-readable storage device produced by Wattz Electronics, based on the tape holography technology, storing their information safely for extended periods of time.<br>This one is labeled, 'Power Armor For Dummies.'"
	soundFile =  'sound/f13items/holodisk_pa.ogg'
	soundLength = 30

/obj/item/weapon/holodisk/powerarmor/playAudio(mob/user)
	if(!src.busy)
		src.busy = 1
		playsound(get_turf(src),src.soundFile,50)
		src.add_fingerprint(user)
		src.icon_state = "[initial(src.icon_state)]anim"
		spawn(src.soundLength)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.martial_art = /datum/martial_art/patraining
				H << "<span class='boldannounce'>You have received the specialized training needed to move in any form of Power Armor.</span>"
			src.icon_state = initial(src.icon_state)
			src.busy = 0
			visible_message("<span class='warning'>[src] self-destructs!</span>")
			qdel(src)
	return

//Krotchy doll, hail Postal. by WalterJe

/obj/item/weapon/krotchy
	name = "krotchy doll"
	desc = "The Bad Touch - Krotchy Doll."
	icon = 'icons/obj/krotchy.dmi'
	icon_state = "doll"
	item_state = "doll"
	throwforce = 0
	hitsound = null
	w_class = 1.0
	throw_speed = 3
	throw_range = 7
	attack_verb = list("Played krotchy")
	var/spam_flag = 0

/obj/item/weapon/krotchy/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	playsound(loc, "krotchy", 50) //plays instead of tap.ogg!
	return ..()

/obj/item/weapon/krotchy/attack_self(mob/user as mob)
	if(spam_flag == 0)
		spam_flag = 1
		playsound(src.loc, "krotchy", 50)
		src.add_fingerprint(user)
		spawn(20)
			spam_flag = 0
	return


/obj/item/weapon/reagent_containers/food/drinks/flask/survival
	name = "metal flask"
	desc = "A metal flask with water, useful in waste's."
	icon_state = "flask"
	materials = list(MAT_GLASS=500)
	volume = 60
	list_reagents = list("water" = 30, "silver_sulfadiazine" = 20, "charcoal" = 10)

/obj/item/weapon/card/id/ncr
	desc = "A pair of standard issue NCR dogtags issued to all servicemen."
	icon_state = "ncr"
	item_state = "silver_id"

/obj/item/weapon/card/id/ncr/ranger
	desc = "A ranger pin issue to all NCR Rangers."
	icon_state = "ranger"
	item_state = "gold_id"

/obj/item/weapon/card/id/bos
	desc = "A pair of Brotherhood of Steel holotags."
	icon_state = "bos"
	item_state = "gold_id"