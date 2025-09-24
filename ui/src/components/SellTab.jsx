import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { ChevronDown } from 'lucide-react';
import { Button } from '@/components/ui/button';
import TokenSelector from '@/components/TokenSelector';
import { toast } from '@/components/ui/use-toast';

const SellTab = () => {
  const [selectedToken, setSelectedToken] = useState({ symbol: 'ETH', name: 'Ethereum', icon: '🔷' });
  const [amount, setAmount] = useState('0');
  const [showTokenSelector, setShowTokenSelector] = useState(false);

  const handleSell = () => {
    toast({
      title: "🚧 This feature isn't implemented yet—but don't worry! You can request it in your next prompt! 🚀"
    });
  };

  return (
    <div className="space-y-6">
      <div className="text-center">
        <div className="text-sm text-gray-400 mb-4">Sell</div>
        
        <div className="text-6xl font-light text-gray-400 mb-6">{amount}</div>
        <div className="text-sm text-gray-400 mb-6">$0</div>
      </div>

      <div className="bg-gray-800 rounded-xl p-4">
        <button
          onClick={() => setShowTokenSelector(true)}
          className="w-full flex items-center justify-between p-4 hover:bg-gray-700 rounded-xl transition-colors"
        >
          <div className="flex items-center space-x-3">
            <span className="text-2xl">{selectedToken.icon}</span>
            <span className="font-medium text-white text-lg">{selectedToken.symbol}</span>
          </div>
          <ChevronDown className="w-5 h-5 text-gray-400" />
        </button>
      </div>

      <div className="bg-gray-800 rounded-xl p-4">
        <div className="flex items-center justify-between mb-2">
          <span className="text-sm text-gray-400">Buy</span>
        </div>
        <div className="flex items-center space-x-3">
          <input
            type="text"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
            placeholder="0"
            className="flex-1 bg-transparent text-2xl font-semibold text-white outline-none"
          />
          <button className="flex items-center space-x-2 bg-gray-700 hover:bg-gray-600 rounded-xl px-3 py-2 transition-colors">
            <span className="text-lg">💵</span>
            <span className="font-medium text-white">USDC</span>
            <ChevronDown className="w-4 h-4 text-gray-400" />
          </button>
        </div>
        <div className="text-right text-sm text-gray-400 mt-1">$0</div>
      </div>

      <Button
        onClick={handleSell}
        className="w-full bg-gradient-to-r from-pink-500 to-purple-500 hover:from-pink-600 hover:to-purple-600 text-white font-medium py-4 rounded-xl text-lg"
      >
        Connect wallet
      </Button>

      <TokenSelector
        isOpen={showTokenSelector}
        onClose={() => setShowTokenSelector(false)}
        onSelect={(token) => {
          setSelectedToken(token);
          setShowTokenSelector(false);
        }}
      />
    </div>
  );
};

export default SellTab;