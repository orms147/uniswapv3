import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { Settings, ChevronDown, Info } from 'lucide-react';
import { Button } from '@/components/ui/button';
import TokenSelector from '@/components/TokenSelector';
import { toast } from '@/components/ui/use-toast';

const LimitTab = () => {
  const [sellToken, setSellToken] = useState({ symbol: 'ETH', name: 'Ethereum', icon: '🔷' });
  const [buyToken, setBuyToken] = useState({ symbol: 'USDC', name: 'USD Coin', icon: '💵' });
  const [sellAmount, setSellAmount] = useState('');
  const [buyAmount, setBuyAmount] = useState('');
  const [limitPrice, setLimitPrice] = useState('');
  const [showSellSelector, setShowSellSelector] = useState(false);
  const [showBuySelector, setShowBuySelector] = useState(false);
  const [slippage, setSlippage] = useState('5.50');
  const [deadline, setDeadline] = useState('30 minutes');

  const handleSettings = () => {
    toast({
      title: "🚧 This feature isn't implemented yet—but don't worry! You can request it in your next prompt! 🚀"
    });
  };

  const handlePlaceOrder = () => {
    toast({
      title: "🚧 This feature isn't implemented yet—but don't worry! You can request it in your next prompt! 🚀"
    });
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between mb-4">
        <span className="text-lg font-semibold text-white">Limit</span>
        <Button
          variant="ghost"
          size="icon"
          onClick={handleSettings}
          className="text-gray-400 hover:text-white"
        >
          <Settings className="w-4 h-4" />
        </Button>
      </div>

      <div className="space-y-4">
        <div className="bg-gray-800 rounded-xl p-4">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm text-gray-400">Sell</span>
            <span className="text-sm text-gray-400">Balance: 0</span>
          </div>
          <div className="flex items-center space-x-3">
            <input
              type="text"
              value={sellAmount}
              onChange={(e) => setSellAmount(e.target.value)}
              placeholder="0"
              className="flex-1 bg-transparent text-2xl font-semibold text-white outline-none"
            />
            <button
              onClick={() => setShowSellSelector(true)}
              className="flex items-center space-x-2 bg-gray-700 hover:bg-gray-600 rounded-xl px-3 py-2 transition-colors"
            >
              <span className="text-lg">{sellToken.icon}</span>
              <span className="font-medium text-white">{sellToken.symbol}</span>
              <ChevronDown className="w-4 h-4 text-gray-400" />
            </button>
          </div>
          <div className="text-right text-sm text-gray-400 mt-1">$0</div>
        </div>

        <div className="bg-gray-800 rounded-xl p-4">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm text-gray-400">Buy</span>
            <span className="text-sm text-gray-400">Balance: 0</span>
          </div>
          <div className="flex items-center space-x-3">
            <input
              type="text"
              value={buyAmount}
              onChange={(e) => setBuyAmount(e.target.value)}
              placeholder="0"
              className="flex-1 bg-transparent text-2xl font-semibold text-white outline-none"
            />
            <button
              onClick={() => setShowBuySelector(true)}
              className="flex items-center space-x-2 bg-gray-700 hover:bg-gray-600 rounded-xl px-3 py-2 transition-colors"
            >
              <span className="text-lg">{buyToken.icon}</span>
              <span className="font-medium text-white">{buyToken.symbol}</span>
              <ChevronDown className="w-4 h-4 text-gray-400" />
            </button>
          </div>
          <div className="text-right text-sm text-gray-400 mt-1">$0</div>
        </div>

        <div className="bg-gray-800 rounded-xl p-4 space-y-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-2">
              <span className="text-sm text-gray-300">Max slippage</span>
              <Info className="w-4 h-4 text-gray-400" />
            </div>
            <div className="flex items-center space-x-2">
              <span className="bg-pink-500 text-white px-2 py-1 rounded text-sm">Auto</span>
              <span className="text-white">{slippage}%</span>
            </div>
          </div>

          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-2">
              <span className="text-sm text-gray-300">Swap deadline</span>
              <Info className="w-4 h-4 text-gray-400" />
            </div>
            <span className="text-white">{deadline}</span>
          </div>

          <div className="flex items-center justify-between">
            <span className="text-sm text-gray-300">Trade options</span>
            <span className="text-gray-400">Default</span>
          </div>

          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-2">
              <span className="text-sm text-gray-300">1-click swaps</span>
              <Info className="w-4 h-4 text-gray-400" />
            </div>
            <div className="w-12 h-6 bg-pink-500 rounded-full flex items-center justify-end px-1">
              <div className="w-4 h-4 bg-white rounded-full"></div>
            </div>
          </div>
        </div>
      </div>

      <Button
        onClick={handlePlaceOrder}
        className="w-full bg-gradient-to-r from-pink-500 to-purple-500 hover:from-pink-600 hover:to-purple-600 text-white font-medium py-4 rounded-xl text-lg"
      >
        Connect wallet
      </Button>

      <TokenSelector
        isOpen={showSellSelector}
        onClose={() => setShowSellSelector(false)}
        onSelect={(token) => {
          setSellToken(token);
          setShowSellSelector(false);
        }}
      />

      <TokenSelector
        isOpen={showBuySelector}
        onClose={() => setShowBuySelector(false)}
        onSelect={(token) => {
          setBuyToken(token);
          setShowBuySelector(false);
        }}
      />
    </div>
  );
};

export default LimitTab;