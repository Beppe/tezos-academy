type storage is unit

type parameter is
  Fire of int
| Stop

type return is list (operation) * storage

const right_laser_address : address = ("tz1fND4ejogxWN7HB5JKdz119A48Cp2eYKj9" : address)
const left_laser_address : address = ("tz1PVWEWDcuow9R6y5EFwcHbFNoZBZ9RjxaB" : address)

function orders (const param : unit; const store : storage): return is {
  const right_laser : contract (parameter) =
    case (Tezos.get_contract_opt(right_laser_address) : option (contract (parameter))) of [
      Some (contract) -> contract
      | None -> (failwith ("Contract not found.") : contract (parameter))
    ];
  const left_laser : contract (parameter) =
    case (Tezos.get_contract_opt(left_laser_address) : option (contract (parameter))) of [
        Some (contract) -> contract
      | None -> (failwith ("Contract not found.") : contract (parameter))
    ];

  // Type your solution below
  const operations : list (operation) = list [
    Tezos.transaction (Fire(5), 0tez, right_laser);
    Tezos.transaction (Stop, 0tez, right_laser);
    Tezos.transaction (Fire(5), 0tez, left_laser);
    Tezos.transaction (Stop, 0tez, left_laser);
  ]

} with (operations, store)

type action is Order | Nothing

function main (const a : action; const s : storage) : return is
  case a of [
      Order  -> orders(unit, s)
    | Nothing -> ((nil: list(operation)), s)
  ]
