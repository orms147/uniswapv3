import React, { useState } from 'react';
import { motion } from 'framer-motion';
import SwapTab from '@/components/SwapTab';
import LimitTab from '@/components/LimitTab';
import BuyTab from '@/components/BuyTab';
import SellTab from '@/components/SellTab';

const TradingInterface = () => {
  const [activeTab, setActiveTab] = useState('swap');

  const tabs = [
    { id: 'swap', label: 'Swap' },
    { id: 'limit', label: 'Limit' },
    { id: 'buy', label: 'Buy' },
    { id: 'sell', label: 'Sell' }
  ];

  const renderTabContent = () => {
    switch (activeTab) {
      case 'swap':
        return <SwapTab />;
      case 'limit':
        return <LimitTab />;
      case 'buy':
        return <BuyTab />;
      case 'sell':
        return <SellTab />;
      default:
        return <SwapTab />;
    }
  };

  return (
    <div className="max-w-md mx-auto">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="glass-effect rounded-2xl p-6"
      >
        <div className="flex bg-gray-800 rounded-xl p-1 mb-6">
          {tabs.map((tab) => (
            <button
              key={tab.id}
              onClick={() => setActiveTab(tab.id)}
              className={`flex-1 py-2 px-4 rounded-lg font-medium transition-all ${
                activeTab === tab.id
                  ? 'bg-gray-700 text-white'
                  : 'text-gray-400 hover:text-white'
              }`}
            >
              {tab.label}
            </button>
          ))}
        </div>

        <motion.div
          key={activeTab}
          initial={{ opacity: 0, x: 20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.2 }}
        >
          {renderTabContent()}
        </motion.div>
      </motion.div>
    </div>
  );
};

export default TradingInterface;