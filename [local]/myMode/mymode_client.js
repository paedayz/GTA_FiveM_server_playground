// const spawnPos = [-1077, -1606, 4];

// console.log("test hello")

// on('onClientGameTypeStart', () => {
//     exports.spawnmanager.setAutoSpawnCallback(() => {
//         exports.spawnmanager.spawnPlayer({
//             x: spawnPos[0],
//             y: spawnPos[1],
//             z: spawnPos[2],
//             model: 'a_m_m_prolhost_01'
//         }, () => {
//             encodeURIComponent('chat:addMessage', {
//                 args: [
//                     'Welcome to the party!!'
//                 ]
//             })
//         })
//     })

//     exports.spawnmanager.setAutoSpawn(true)
//     exports.spawnmanager.forceRespawn()
// })

RegisterCommand('hello', (source, args, raw) => {
    emit('chat:addMessage', {
        args: ["Hello player"]
    })
}, false)

Delay = ms => new Promise(res => setTimeout(res, ms))

RegisterCommand('carz', async (source, args, raw) => {
    let model = "adder"
    if (args.length > 0) {
        model = args[0].toString()
    }

    // Check car model exist
    const hash = GetHashKey(model)
    if(!IsModelInCdimage(hash) || !IsModelAVehicle(hash)) {
        // if not have model
        emit('chat:addMessage', {
            args: [`It might have been a good thing that you tried to spawn a ${model}. Who even wants their spawning to actually ^*succeed?`]
        })
        return
    }

    RequestModel(hash);
    while(!HasModelLoaded(hash)) {
        await Delay(500);
    }

    console.log('wtfffff')

    // get player id
    const ped = PlayerPedId();
    // get position of player
    const coords = GetEntityCoords(ped)
    // Create car at player position
    const vehicle = CreateVehicle(hash, coords[0], coords[1], coords[2], GetEntityHeading(ped), true, false)
    // Set the player into the drivers seat of the vehicle
    SetPedIntoVehicle(ped, vehicle, -1)

    // Allow the game engine to clean up the vehicle and model if needed
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeed(model)

    // Tell the player the car spawned
    emit("chat:addMessage", {
        args: [`Wowww! Enjoy your new ${model}`]
    })
}, false)

RegisterCommand('getPosition', (source, args) => {
    // get player id
    const ped = PlayerPedId();
    // get position of player
    const coords = GetEntityCoords(ped)
    emit("chat:addMessage", {
        args: [` [ ${coords[0]} ${coords[1]} ${coords[2]} ]`]
    })
}, false)

RegisterCommand('getPed', (source, args) => {
    console.log('PedID : ', PlayerPedId())
    console.log('PlayerPed : ', GetPlayerPed())
}, false)

// on('chat:addMessage', (p1, p2) => {
//     console.log("test haha")
// })

// onNet('chat:addMessage', (eventParam1, eventParam2) => {
//     console.log(`${eventParam1.args[0]} : said ${eventParam1.args[1]} ...`)
//     // emit("chat:addMessage", {
//     //     args: [`${eventParam1.args[0]} : said ${eventParam1.args[1]} ...`]
//     // })
// })


RegisterCommand('test', (source, args) => {
    addMessage()
}, false)

const addMessage = () => {
    setImmediate(() => {
        emit('chat:addSuggestion', '/command', 'help text', [
          {name:"paramName1", help:"param description 1"},
          {name:"paramName1", help:"param description 2"}
        ]);
      });
}

RegisterCommand('pressK', () => {
    console.log("press K")
}, false)

RegisterKeyMapping('pressK', 'pressKFunction', 'keyboard', 'K')