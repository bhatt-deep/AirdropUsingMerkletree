# AirdropUsingMerkletree
Efficient token Air-drop using Merkle trees

## How it works?:-
1) Owner of contract prepares a list of addresses with many entries and publishes this list in public static .js file in JSON format
2) Owner reads this list, builds the merkle tree structure and writes down the Merkle root of it.
3) Owner creates contract and places calculated Merkle root into it.
4) Owner says to users, that they can claim their tokens, if they owe any of addresses, presented in the list, published on owner's site.
5) User wants to claim his N tokens, he also builds Merkle tree from public list and prepares Merkle proof, consisting from log2N hashes, describing the way to reach Merkle root.
6) User sends transaction with Merkle proof to contract.
7) Contract checks Merkle proof, and, if proof is correct, then sender's address is in list of allowed addresses, and contract does some action for this use. In our case it mints some amount of token.

## How to use this repository?
1) clone this repo
```bash
git clone https://github.com/bhatt-deep/AirdropUsingMerkletree.git
```
2) run truffle commands
```bash
truffle develop
```
```bash
truffle migrate
```
```bash
truffle test
```

## References & Useful links for Merkle Airdrops
1) [rstormsf/merkleairdrop](https://github.com/rstormsf/merkleairdrop)
2) [Merkle Air-Drops: Make Love, Not War](https://blog.ricmoo.com/merkle-air-drops-e6406945584d)
3) [Merkle Airdrop: the Basics](https://medium.com/smartz-blog/merkle-airdrop-the-basics-9a0857fcc930)
