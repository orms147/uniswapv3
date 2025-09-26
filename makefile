-include .env

deploy:; forge script script/DeployMyToken.s.sol:DeployMyToken \
	--rpc-url https://dream-rpc.somnia.network \
	--private-key e459d12d2afefd5e490d33171b8a6e95873db3371b8a001ca4ffa5036b649bf8 \
	--broadcast \
	--gas-limit 4000000 \
	--gas-price 20 \
	--gas-estimate-multiplier 200

