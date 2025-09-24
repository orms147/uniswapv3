import React from 'react';
import { motion } from 'framer-motion';
import { MoreHorizontal, Maximize2, Eye, EyeOff } from 'lucide-react';

const PriceChart = ({ token1, token2, priceRange, marketPrice }) => {
  const timeframes = ['1D', '1W', '1M', '1Y', 'All'];
  const chartMin = marketPrice * 0.8;
  const chartMax = marketPrice * 1.2;

  const valueToPercent = (value) => {
    return ((value - chartMin) / (chartMax - chartMin)) * 100;
  };

  const rangeStartPercent = valueToPercent(priceRange[0]);
  const rangeEndPercent = valueToPercent(priceRange[1]);
  const marketPricePercent = valueToPercent(marketPrice);

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      className="glass-effect rounded-2xl p-6 h-full flex flex-col"
    >
      <div className="flex items-center justify-between mb-4">
        <div className="flex items-center space-x-2">
          {token1 && token2 ? (
            <>
              <span className="text-lg">{token1.icon}</span>
              <span className="text-lg">{token2.icon}</span>
              <span className="text-white font-medium">{token1.symbol} / {token2.symbol}</span>
            </>
          ) : (
            <span className="text-gray-400">Select a pair to see chart</span>
          )}
        </div>
        <div className="flex items-center space-x-1">
          <button className="p-2 text-gray-400 hover:text-white transition-colors rounded-lg hover:bg-gray-700">
            <Maximize2 className="w-4 h-4" />
          </button>
          <button className="p-2 text-gray-400 hover:text-white transition-colors rounded-lg hover:bg-gray-700">
            <MoreHorizontal className="w-4 h-4" />
          </button>
        </div>
      </div>

      <div className="relative flex-grow mb-4">
        <svg className="w-full h-full" viewBox="0 0 400 200" preserveAspectRatio="none">
          <defs>
            <linearGradient id="chartGradient" x1="0%" y1="0%" x2="0%" y2="100%">
              <stop offset="0%" stopColor="#ff007a" stopOpacity="0.3" />
              <stop offset="100%" stopColor="#ff007a" stopOpacity="0" />
            </linearGradient>
            <linearGradient id="rangeGradient" x1="0%" y1="0%" x2="0%" y2="100%">
              <stop offset="0%" stopColor="rgba(252, 114, 255, 0.1)" />
              <stop offset="100%" stopColor="rgba(252, 114, 255, 0.1)" />
            </linearGradient>
          </defs>
          
          <g stroke="#374151" strokeWidth="0.5" opacity="0.3">
            <line x1="0" y1="0" x2="400" y2="0" />
            <line x1="0" y1="50" x2="400" y2="50" />
            <line x1="0" y1="100" x2="400" y2="100" />
            <line x1="0" y1="150" x2="400" y2="150" />
            <line x1="0" y1="200" x2="400" y2="200" />
          </g>

          <path
            d="M 0 150 Q 80 120 160 100 T 320 80 L 400 60"
            stroke="#ff007a"
            strokeWidth="1.5"
            fill="none"
          />
          
          <path
            d="M 0 150 Q 80 120 160 100 T 320 80 L 400 60 L 400 200 L 0 200 Z"
            fill="url(#chartGradient)"
          />

          {token2 && (
            <g>
              <rect x={`${rangeStartPercent}%`} y="0" width={`${rangeEndPercent - rangeStartPercent}%`} height="200" fill="url(#rangeGradient)" />
              <line x1={`${rangeStartPercent}%`} y1="0" x2={`${rangeStartPercent}%`} y2="200" stroke="#FC72FF" strokeWidth="1" strokeDasharray="2 2" />
              <line x1={`${rangeEndPercent}%`} y1="0" x2={`${rangeEndPercent}%`} y2="200" stroke="#FC72FF" strokeWidth="1" strokeDasharray="2 2" />
              <line x1={`${marketPricePercent}%`} y1="0" x2={`${marketPricePercent}%`} y2="200" stroke="#34D399" strokeWidth="1" />
            </g>
          )}
        </svg>

        <div className="absolute top-0 right-0 text-xs text-gray-400 p-1">{chartMax.toLocaleString(undefined, {notation: 'compact'})}</div>
        <div className="absolute bottom-0 right-0 text-xs text-gray-400 p-1">{chartMin.toLocaleString(undefined, {notation: 'compact'})}</div>
      </div>

      <div className="flex items-center justify-center">
        <div className="flex space-x-2 bg-[#1D2330] p-1 rounded-lg">
          {timeframes.map((timeframe) => (
            <button
              key={timeframe}
              className={`px-3 py-1 rounded-md text-xs font-medium transition-colors ${
                timeframe === '1D'
                  ? 'bg-gray-700 text-white'
                  : 'text-gray-400 hover:text-white'
              }`}
            >
              {timeframe}
            </button>
          ))}
        </div>
      </div>
    </motion.div>
  );
};

export default PriceChart;