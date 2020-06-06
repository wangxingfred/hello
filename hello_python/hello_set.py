species = {"human", "dinosaur", "whale"}

print({e for e in species})

print([e for e in species])

print([(idx, e) for idx, e in enumerate(species)])
