-include .env

# Deployment commands
deploy-all:; forge script src/script/CompleteDeployment.s.sol:CompleteDeployment \
	--rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) \
	--broadcast \
	--verify \
	--etherscan-api-key $(ETHERSCAN_API_KEY)	

deploy-factory:; forge script src/script/DeployFactory.s.sol:DeployFactory \
	--rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) \
	--broadcast \
	--verify \
	--etherscan-api-key $(ETHERSCAN_API_KEY)

deploy-router:; forge script src/script/DeploySwapRouter.s.sol:DeploySwapRouter \
	--rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) \
	--broadcast \
	--verify \
	--etherscan-api-key $(ETHERSCAN_API_KEY)

deploy-nft-manager:; forge script src/script/DeployNonfungiblePositionManager.s.sol:DeployNonfungiblePositionManager \
	--rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) \
	--broadcast \
	--verify \
	--etherscan-api-key $(ETHERSCAN_API_KEY)

deploy-migrator:; forge script src/script/DeployV3Migrator.s.sol:DeployV3Migrator \
	--rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) \
	--broadcast \
	--verify \
	--etherscan-api-key $(ETHERSCAN_API_KEY)

create-pool:; forge script src/script/CreatePool.s.sol:CreatePool \
	--rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) \
	--broadcast \
	--verify \
	--etherscan-api-key $(ETHERSCAN_API_KEY)

initialize-pool:; forge script src/script/InitializePool.s.sol:InitializePool \
	--rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) \
	--broadcast \
	--verify \
	--etherscan-api-key $(ETHERSCAN_API_KEY)

# Test deployment
test-deployment:; forge script src/script/TestDeployment.s.sol:TestDeployment \
	--rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY)

# Simple factory test
test-factory:; forge script src/script/DeployFactoryTest.s.sol:DeployFactoryTest \
	--rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) \
	--broadcast

# Quick factory deployment
quick-factory:; forge script src/script/QuickDeployFactory.s.sol:QuickDeployFactory \
	--rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) \
	--broadcast

# Simple factory test (no verification)
simple-factory:; forge script src/script/SimpleFactoryTest.s.sol:SimpleFactoryTest \
	--rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) \
	--broadcast

# Build and test commands
build:; forge build
test:; forge test
clean:; forge clean

# Help command
help:; @echo "Available commands:"; \
	echo "  deploy-all        - Deploy all contracts"; \
	echo "  deploy-factory    - Deploy factory"; \
	echo "  deploy-router     - Deploy swap router"; \
	echo "  deploy-nft-manager- Deploy NFT position manager"; \
	echo "  deploy-migrator   - Deploy V3 migrator"; \
	echo "  create-pool       - Create a new pool"; \
	echo "  initialize-pool   - Initialize a pool"; \
	echo "  test-deployment   - Test deployed contracts"; \
	echo "  test-factory      - Test factory deployment"; \
	echo "  quick-factory     - Quick factory deployment"; \
	echo "  simple-factory    - Simple factory test (no verification)"; \
	echo "  build             - Build contracts"; \
	echo "  test              - Run tests"; \
	echo "  clean             - Clean build artifacts"; \
	echo "  help              - Show this help"