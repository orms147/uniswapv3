import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { ChevronDown, Plus, Minus, Search, Maximize2 } from 'lucide-react';
import { Button } from '@/components/ui/button';
import TokenSelector from '@/components/TokenSelector';
import { toast } from '@/components/ui/use-toast';

const PoolInterface = () => {
  const [step, setStep] = useState(1);
  const [token1, setToken1] = useState({ symbol: 'WBTC', name: 'Wrapped Bitcoin', icon: '₿' });
  const [token2, setToken2] = useState({ symbol: 'USDT', name: 'Tether', icon: '💰' });
  const [amount1, setAmount1] = useState('123');
  const [amount2, setAmount2] = useState('15962735.395932');
  const [showToken1Selector, setShowToken1Selector] = useState(false);
  const [showToken2Selector, setShowToken2Selector] = useState(false);
  const [feeTier, setFeeTier] = useState('0.3');
  const [minPrice, setMinPrice] = useState(108534.21);
  const [maxPrice, setMaxPrice] = useState(115245.25);
  const marketPrice = 112087.00;
  const [rangeMode, setRangeMode] = useState('custom');
  const timeframes = ['1D', '1W', '1M', '1Y', 'All time'];

  const handleContinue = () => {
    if (step === 1 && token1 && token2) {
      setStep(2);
    } else if (!token1 || !token2) {
       toast({
        title: "Please select a pair of tokens.",
        variant: "destructive",
      });
    } else {
      handleConnectWallet();
    }
  };

  const handleConnectWallet = () => {
    toast({
      title: "🚧 This feature isn't implemented yet—but don't worry! You can request it in your next prompt! 🚀"
    });
  };

  const handlePriceAdjust = (setter, amount) => {
      setter(prev => parseFloat((prev + amount).toFixed(2)));
  };

  return (
    <div className="max-w-lg mx-auto">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="glass-effect rounded-2xl p-6"
      >
        <div className="flex items-center justify-between mb-6">
            <h2 className="text-xl font-medium text-white">Add Liquidity</h2>
            <Button variant="ghost" size="sm" onClick={() => setStep(1)} className={step === 1 ? 'invisible' : 'visible'}>Back</Button>
        </div>

        {step === 1 && (
          <motion.div initial={{opacity: 0}} animate={{opacity: 1}} className="space-y-6">
            <div>
              <h3 className="text-md font-medium text-gray-300 mb-3">Select Pair</h3>
              <div className="flex space-x-4">
                <button
                  onClick={() => setShowToken1Selector(true)}
                  className="flex items-center space-x-2 bg-[#1D2330] hover:bg-gray-700 rounded-xl px-4 py-3 transition-colors flex-1"
                >
                  <span className="text-lg">{token1.icon}</span>
                  <span className="font-medium text-white">{token1.symbol}</span>
                  <ChevronDown className="w-4 h-4 text-gray-400 ml-auto" />
                </button>

                <button
                  onClick={() => setShowToken2Selector(true)}
                  className="flex items-center justify-center space-x-2 bg-[#1D2330] hover:bg-gray-700 rounded-xl px-4 py-3 transition-colors flex-1"
                >
                  {token2 ? (
                    <>
                      <span className="text-lg">{token2.icon}</span>
                      <span className="font-medium text-white">{token2.symbol}</span>
                      <ChevronDown className="w-4 h-4 text-gray-400 ml-auto" />
                    </>
                  ) : (
                    <span className="text-gray-400">Choose token</span>
                  )}
                </button>
              </div>
            </div>

            <div>
              <h3 className="text-md font-medium text-gray-300 mb-3">Fee Tier</h3>
              <div className="bg-[#1D2330] rounded-xl p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-white font-medium">{feeTier}% fee tier</div>
                    <div className="text-gray-400 text-sm">Best for stable pairs</div>
                  </div>
                  <Button variant="ghost" size="sm">Edit</Button>
                </div>
              </div>
            </div>

            <Button
              onClick={handleContinue}
              className="w-full bg-gradient-to-r from-pink-500 to-purple-500 hover:from-pink-600 hover:to-purple-600 text-white font-medium py-4 rounded-xl text-lg"
            >
              Set Price Range
            </Button>
          </motion.div>
        )}

        {step === 2 && (
          <motion.div initial={{opacity: 0}} animate={{opacity: 1}} className="space-y-6">
            <div>
              <h3 className="text-md font-medium text-gray-300 mb-3">Set price range</h3>
              <div className="flex bg-[#1D2330] rounded-full p-1 mb-4">
                  <button onClick={() => setRangeMode('full')} className={`flex-1 py-2 px-4 rounded-full font-medium transition-all text-sm ${rangeMode === 'full' ? 'bg-gray-700 text-white' : 'text-gray-400 hover:text-white'}`}>
                      Full range
                  </button>
                  <button onClick={() => setRangeMode('custom')} className={`flex-1 py-2 px-4 rounded-full font-medium transition-all text-sm ${rangeMode === 'custom' ? 'bg-gray-700 text-white' : 'text-gray-400 hover:text-white'}`}>
                      Custom range
                  </button>
              </div>
              <p className="text-gray-400 text-sm mb-4">
                  Custom range allows you to concentrate your liquidity within specific price bounds, enhancing capital efficiency and fee earnings but requiring more active management.
              </p>

              <div className="bg-[#1D2330] rounded-xl p-4 mb-4">
                  <div className="flex items-center justify-between mb-4">
                      <span className="text-sm text-gray-300">Market price: <span className="text-white font-medium">{marketPrice.toLocaleString()} {token2?.symbol} = 1 {token1.symbol}</span> (${(marketPrice * 1.0004).toLocaleString()})</span>
                      <div className="flex items-center space-x-1">
                          <div className="flex items-center space-x-1 bg-gray-900 px-2 py-1 rounded-full">
                              <span className="text-sm">{token1.icon}</span>
                              <span className="text-xs font-bold text-white">{token1.symbol}</span>
                          </div>
                          <div className="flex items-center space-x-1 bg-green-500/20 px-2 py-1 rounded-full">
                              <span className="text-sm">{token2.icon}</span>
                              <span className="text-xs font-bold text-green-300">{token2.symbol}</span>
                          </div>
                      </div>
                  </div>
                  
                  <div className="relative h-40 mb-4">
                      <svg className="w-full h-full" viewBox="0 0 400 160" preserveAspectRatio="none">
                          <defs>
                              <linearGradient id="chartGradient" x1="0%" y1="0%" x2="0%" y2="100%">
                                  <stop offset="0%" stopColor="#ff007a" stopOpacity="0.3" />
                                  <stop offset="100%" stopColor="#ff007a" stopOpacity="0" />
                              </linearGradient>
                          </defs>
                          <g stroke="#374151" strokeWidth="0.5" opacity="0.3">
                              <line x1="0" y1="40" x2="400" y2="40" /><text x="370" y="40" fill="#888" fontSize="10">115.2k</text>
                              <line x1="0" y1="80" x2="400" y2="80" /><text x="370" y="80" fill="#888" fontSize="10">112.1k</text>
                              <line x1="0" y1="120" x2="400" y2="120" /><text x="370" y="120" fill="#888" fontSize="10">108.5k</text>
                          </g>
                          <path d="M 0 120 Q 50 100, 100 90 T 200 70 T 300 80 T 400 60" stroke="#ff007a" strokeWidth="1.5" fill="none" />
                          <path d="M 0 120 Q 50 100, 100 90 T 200 70 T 300 80 T 400 60 L 400 160 L 0 160 Z" fill="url(#chartGradient)" />
                      </svg>
                  </div>

                  <div className="flex items-center justify-between">
                      <div className="flex space-x-1">
                          {timeframes.map((timeframe) => (
                              <button key={timeframe} className={`px-2 py-1 rounded-md text-xs font-medium transition-colors ${timeframe === '1D' ? 'bg-gray-700 text-white' : 'text-gray-400 hover:text-white'}`}>
                                  {timeframe}
                              </button>
                          ))}
                      </div>
                      <div className="flex items-center space-x-1 text-gray-400">
                          <button className="p-1 hover:text-white"><Search size={14} /></button>
                          <button className="p-1 hover:text-white"><Maximize2 size={14} /></button>
                          <button className="p-1 text-xs hover:text-white">Reset</button>
                      </div>
                  </div>
              </div>

              <div className="grid grid-cols-2 gap-4 mb-6">
                  <div className="bg-[#1D2330] rounded-xl p-4">
                      <div className="flex justify-between items-start">
                          <div>
                              <div className="text-gray-400 text-sm mb-1">Min price</div>
                              <div className="text-white text-lg font-medium">{minPrice.toLocaleString()}</div>
                              <div className="text-gray-400 text-sm">{token2?.symbol} per {token1.symbol}</div>
                          </div>
                          <div className="flex flex-col space-y-2">
                              <button onClick={() => handlePriceAdjust(setMinPrice, 100)} className="w-7 h-7 flex items-center justify-center bg-gray-700 rounded-md hover:bg-gray-600"><Plus size={16} /></button>
                              <button onClick={() => handlePriceAdjust(setMinPrice, -100)} className="w-7 h-7 flex items-center justify-center bg-gray-700 rounded-md hover:bg-gray-600"><Minus size={16} /></button>
                          </div>
                      </div>
                  </div>
                  <div className="bg-[#1D2330] rounded-xl p-4">
                      <div className="flex justify-between items-start">
                          <div>
                              <div className="text-gray-400 text-sm mb-1">Max price</div>
                              <div className="text-white text-lg font-medium">{maxPrice.toLocaleString()}</div>
                              <div className="text-gray-400 text-sm">{token2?.symbol} per {token1.symbol}</div>
                          </div>
                          <div className="flex flex-col space-y-2">
                              <button onClick={() => handlePriceAdjust(setMaxPrice, 100)} className="w-7 h-7 flex items-center justify-center bg-gray-700 rounded-md hover:bg-gray-600"><Plus size={16} /></button>
                              <button onClick={() => handlePriceAdjust(setMaxPrice, -100)} className="w-7 h-7 flex items-center justify-center bg-gray-700 rounded-md hover:bg-gray-600"><Minus size={16} /></button>
                          </div>
                      </div>
                  </div>
              </div>
            </div>

            <div>
              <h3 className="text-md font-medium text-gray-300 mb-3">Deposit tokens</h3>
              <div className="space-y-4">
                <div className="bg-[#1D2330] rounded-xl p-4">
                  <div className="flex items-start justify-between">
                      <div>
                          <input
                              type="text"
                              value={amount1}
                              onChange={(e) => setAmount1(e.target.value)}
                              placeholder="0"
                              className="bg-transparent text-2xl font-medium text-red-400 outline-none w-full"
                          />
                          <span className="text-sm text-gray-400">$13.83M</span>
                      </div>
                      <div className="text-right">
                          <div className="flex items-center space-x-2 mb-1">
                              <span className="text-lg">{token1.icon}</span>
                              <span className="font-medium text-white">{token1.symbol}</span>
                          </div>
                          <span className="text-sm text-red-400">0 {token1.symbol}</span>
                      </div>
                  </div>
                </div>

                <div className="bg-[#1D2330] rounded-xl p-4">
                  <div className="flex items-start justify-between">
                      <div>
                          <input
                              type="text"
                              value={amount2}
                              onChange={(e) => setAmount2(e.target.value)}
                              placeholder="0"
                              className="bg-transparent text-2xl font-medium text-red-400 outline-none w-full"
                          />
                          <span className="text-sm text-gray-400">$15.97M</span>
                      </div>
                      <div className="text-right">
                          <div className="flex items-center space-x-2 mb-1">
                              <span className="text-lg">{token2.icon}</span>
                              <span className="font-medium text-white">{token2.symbol}</span>
                          </div>
                          <span className="text-sm text-red-400">0 {token2.symbol}</span>
                      </div>
                  </div>
                </div>
              </div>
            </div>

            <Button
              onClick={handleConnectWallet}
              className="w-full bg-gradient-to-r from-pink-500 to-purple-500 hover:from-pink-600 hover:to-purple-600 text-white font-medium py-4 rounded-xl text-lg"
            >
              Connect Wallet
            </Button>
          </motion.div>
        )}

        <TokenSelector
          isOpen={showToken1Selector}
          onClose={() => setShowToken1Selector(false)}
          onSelect={(token) => {
            setToken1(token);
            setShowToken1Selector(false);
          }}
        />

        <TokenSelector
          isOpen={showToken2Selector}
          onClose={() => setShowToken2Selector(false)}
          onSelect={(token) => {
            setToken2(token);
            setShowToken2Selector(false);
          }}
        />
      </motion.div>
    </div>
  );
};

export default PoolInterface;