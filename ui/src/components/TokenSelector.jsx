import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X, Search } from 'lucide-react';
import { Button } from '@/components/ui/button';

const TokenSelector = ({ isOpen, onClose, onSelect }) => {
  const [searchTerm, setSearchTerm] = useState('');

  const tokens = [
    { symbol: 'ETH', name: 'Ethereum', icon: '🔷', balance: '0.0' },
    { symbol: 'USDC', name: 'USD Coin', icon: '💵', balance: '0.0' },
    { symbol: 'USDT', name: 'Tether', icon: '💰', balance: '0.0' },
    { symbol: 'WBTC', name: 'Wrapped Bitcoin', icon: '₿', balance: '0.0' },
    { symbol: 'DAI', name: 'Dai Stablecoin', icon: '🟡', balance: '0.0' },
    { symbol: 'UNI', name: 'Uniswap', icon: '🦄', balance: '0.0' },
    { symbol: 'LINK', name: 'Chainlink', icon: '🔗', balance: '0.0' },
    { symbol: 'AAVE', name: 'Aave', icon: '👻', balance: '0.0' }
  ];

  const filteredTokens = tokens.filter(token =>
    token.symbol.toLowerCase().includes(searchTerm.toLowerCase()) ||
    token.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <AnimatePresence>
      {isOpen && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4"
          onClick={onClose}
        >
          <motion.div
            initial={{ scale: 0.9, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            exit={{ scale: 0.9, opacity: 0 }}
            className="bg-gray-900 rounded-2xl p-6 w-full max-w-md max-h-[80vh] overflow-hidden"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-lg font-semibold text-white">Select a token</h3>
              <Button
                variant="ghost"
                size="icon"
                onClick={onClose}
                className="text-gray-400 hover:text-white"
              >
                <X className="w-5 h-5" />
              </Button>
            </div>

            <div className="relative mb-4">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" />
              <input
                type="text"
                placeholder="Search name or paste address"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="w-full bg-gray-800 rounded-xl pl-10 pr-4 py-3 text-white placeholder-gray-400 outline-none focus:ring-2 focus:ring-pink-500"
              />
            </div>

            <div className="space-y-2 max-h-96 overflow-y-auto">
              {filteredTokens.map((token) => (
                <button
                  key={token.symbol}
                  onClick={() => onSelect(token)}
                  className="w-full flex items-center justify-between p-3 hover:bg-gray-800 rounded-xl transition-colors"
                >
                  <div className="flex items-center space-x-3">
                    <span className="text-2xl">{token.icon}</span>
                    <div className="text-left">
                      <div className="font-medium text-white">{token.symbol}</div>
                      <div className="text-sm text-gray-400">{token.name}</div>
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="text-white">{token.balance}</div>
                  </div>
                </button>
              ))}
            </div>
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  );
};

export default TokenSelector;