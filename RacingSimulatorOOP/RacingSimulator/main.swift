import Foundation

//Land transport
var bactrianCamel = BactrianCamel()
var fastCamel = FastCamel()
var centaur = Centaur()
var allTerrainBoots = AllTerrainBoots()

//Air transport
var flyingCarpet = FlyingCarpet()
var bucket = Bucket()
var broom = Broom()

//RaceSimulatot
var raceSimulator = RaceSimulator()

//print(fastCamel.getFinalTime(distance: 1000))

//print(bactrianCamel.getFinalTime(distance: 1000))
//print(fastCamel.getFinalTime(distance: 1000))
//print(centaur.getFinalTime(distance: 1000))
//print(allTerrainBoots.getFinalTime(distance: 1000))
//print(flyingCarpet.getFinalTime(distance: 1000))
//print(bucket.getFinalTime(distance: 1000))
//print(broom.getFinalTime(distance: 1000))

//raceSimulator.registrationOnAirRace(args: flyingCarpet, bucket, broom)
//raceSimulator.registrationOnAirRace(args: flyingCarpet, bucket, broom)
//var winner1 = raceSimulator.startRaceAndFindWinner(distance: 7000)
//
//raceSimulator.registrationOnLandRace(args: fastCamel, bactrianCamel, centaur, allTerrainBoots)
//raceSimulator.registrationOnAirRace(args: flyingCarpet, bucket, broom)
//var winner2 = raceSimulator.startRaceAndFindWinner(distance: 300000)
//
//raceSimulator.registrationOnMultiRace(args: flyingCarpet, bucket, broom, fastCamel, bactrianCamel, centaur, allTerrainBoots)
//raceSimulator.registrationOnLandRace(args: fastCamel, bactrianCamel, centaur, allTerrainBoots)
//var winner3 = raceSimulator.startRaceAndFindWinner(distance: 100000000)
//
//var winner4 = raceSimulator.startRaceAndFindWinner(distance: 100000000)

raceSimulator.registrationOnLandRace(args: bactrianCamel, fastCamel, centaur)
var wainner1 = raceSimulator.startRaceAndFindWinner(distance: 1000)

raceSimulator.registrationOnAirRace(args: flyingCarpet, bucket, broom)
var winner2 = raceSimulator.startRaceAndFindWinner(distance: 1000)

raceSimulator.registrationOnMultiRace(args: flyingCarpet, allTerrainBoots, fastCamel)
var winner3 = raceSimulator.startRaceAndFindWinner(distance: 1000)
