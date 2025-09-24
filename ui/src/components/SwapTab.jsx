import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { ArrowUpDown, Settings, ChevronDown } from 'lucide-react';
import { Button } from '@/components/ui/button';
import TokenSelector from '@/components/TokenSelector';
import { toast } from '@/components/ui/use-toast';

const SwapTab = () => {
  const [fromToken, setFromToken] = useState({ symbol: 'ETH', name: 'Ethereum', icon: '🔷' });
  const [toToken, setToToken] = useState({ symbol: 'USDC', name: 'USD Coin', icon: '💵' });
  const [fromAmount, setFromAmount] = useState('');
  const [toAmount, setToAmount] = useState('');
  const [showFromSelector, setShowFromSelector] = useState(false);
  const [showToSelector, setShowToSelector] = useState(false);

  const handleSwapTokens = () => {
    const temp = fromToken;
    setFromToken(toToken);
    setToToken(temp);
    setFromAmount(toAmount);
    setToAmount(fromAmount);
  };

  const handleSwap = () => {
    toast({
      title: "🚧 This feature isn't implemented yet—but don't worry! You can request it in your next prompt! 🚀"
    });
  };

  const handleSettings = () => {
    toast({
      title: "🚧 This feature isn't implemented yet—but don't worry! You can request it in your next prompt! 🚀"
    });
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between mb-4">
        <span className="text-lg font-semibold text-white">Swap</span>
        <Button
          variant="ghost"
          size="icon"
          onClick={handleSettings}
          className="text-gray-400 hover:text-white"
        >
          <Settings className="w-4 h-4" />
        </Button>
      </div>

      <div className="space-y-2">
        <div className="bg-gray-800 rounded-xl p-4">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm text-gray-400">You pay</span>
            <span className="text-sm text-gray-400">Balance: 0</span>
          </div>
          <div className="flex items-center space-x-3">
            <input
              type="text"
              value={fromAmount}
              onChange={(e) => setFromAmount(e.target.value)}
              placeholder="0"
              className="flex-1 bg-transparent text-2xl font-semibold text-white outline-none"
            />
            <button
              onClick={() => setShowFromSelector(true)}
              className="flex items-center space-x-2 bg-gray-700 hover:bg-gray-600 rounded-xl px-3 py-2 transition-colors"
            >
              <span className="text-lg">{fromToken.icon}</span>
              <span className="font-medium text-white">{fromToken.symbol}</span>
              <ChevronDown className="w-4 h-4 text-gray-400" />
            </button>
          </div>
          <div className="text-right text-sm text-gray-400 mt-1">$0</div>
        </div>

        <div className="flex justify-center">
          <motion.button
            whileHover={{ scale: 1.1 }}
            whileTap={{ scale: 0.9 }}
            onClick={handleSwapTokens}
            className="bg-gray-800 hover:bg-gray-700 rounded-xl p-2 transition-colors"
          >
            <ArrowUpDown className="w-4 h-4 text-gray-400" />
          </motion.button>
        </div>

        <div className="bg-gray-800 rounded-xl p-4">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm text-gray-400">You receive</span>
            <span className="text-sm text-gray-400">Balance: 0</span>
          </div>
          <div className="flex items-center space-x-3">
            <input
              type="text"
              value={toAmount}
              onChange={(e) => setToAmount(e.target.value)}
              placeholder="0"
              className="flex-1 bg-transparent text-2xl font-semibold text-white outline-none"
            />
            <button
              onClick={() => setShowToSelector(true)}
              className="flex items-center space-x-2 bg-gray-700 hover:bg-gray-600 rounded-xl px-3 py-2 transition-colors"
            >
              <span className="text-lg">{toToken.icon}</span>
              <span className="font-medium text-white">{toToken.symbol}</span>
              <ChevronDown className="w-4 h-4 text-gray-400" />
            </button>
          </div>
          <div className="text-right text-sm text-gray-400 mt-1">$0</div>
        </div>
      </div>

      <Button
        onClick={handleSwap}
        className="w-full bg-gradient-to-r from-pink-500 to-purple-500 hover:from-pink-600 hover:to-purple-600 text-white font-medium py-4 rounded-xl text-lg"
      >
        Connect wallet
      </Button>

      <TokenSelector
        isOpen={showFromSelector}
        onClose={() => setShowFromSelector(false)}
        onSelect={(token) => {
          setFromToken(token);
          setShowFromSelector(false);
        }}
      />

      <TokenSelector
        isOpen={showToSelector}
        onClose={() => setShowToSelector(false)}
        onSelect={(token) => {
          setToToken(token);
          setShowToSelector(false);
        }}
      />
    </div>
  );
};

export default SwapTab;