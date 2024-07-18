//Q1.1 : Extend Date object with daysTo() method

/**
 * Take the difference between the dates and divide by milliseconds per day.
 * Round down to nearest whole number.
 * @param {Date} d2 
 * @returns numOfCompleteDays
 */

Date.prototype.daysTo = function(d2){
    let time_difference = d2.getTime() - this.getTime();
    let days_difference = time_difference / (3600 * 24 * 1000);
    let numOfCompleteDays = Math.abs(Math.floor(days_difference));
    return numOfCompleteDays;
}

let d1 = new Date('2023-07-11');
let d2 = new Date('2024-06-07');
console.log(d1.daysTo(d2));  // 332

document.write('<h2>'+'Q1.1 : Number of complete days between any pair of JS date objects:  ' + d1.daysTo(d2)+'</h2>');



//Q1.2 : Develop a program which produces ordered array of sales.

// Input array
const sales = [
    { amount: 10000, quantity: 10 },
    { amount: 800, quantity: 25 },
    { amount: 540, quantity: 51 },
    { amount: 200, quantity: 33 },
    { amount: 440, quantity: 12 }
  ];

// Calculate totals and order sales by total
function orderByTotal(sales) {
  const totalOfSales = sales.map(sale => {
    return {
      amount: sale.amount,
      quantity: sale.quantity,
      total: sale.amount * sale.quantity
    };
  });

  // Sort the totalOfSales array by total in ascending order
  const orderedSales = totalOfSales.sort((a, b) => a.total - b.total);

  return orderedSales;
}

const orderedSales = orderByTotal(sales);
console.log('Order by Total:', orderedSales);

document.write('<h2>'+'Q1.2 : Order by Total : '+ '</h2>');

for (let i = 0; i < orderedSales.length; i++) {
  document.write('<h3>'+ JSON.stringify(orderedSales[i])+'</h3>');
}


//Q1.3: Develop a program Object Projection.

// Input src object
const src = {
    prop11: {
      prop21: 21,
      prop22: {
        prop31: 31,
        prop32: 32,
      },
    },
    prop12: 12,
  };
  
  // Input proto object
  const proto = {
    prop11: {
      prop22: null,
    },
  };
  
/**
 * 
 * @param {Object} source 
 * @param {Object} prototype 
 * @returns projected
 */

  function project(source, prototype) {
    const projected = {};
    for (const key in prototype) {
      if (key in source) {        
          const projectedValue = project(source[key], prototype[key]);
          if (Object.keys(projectedValue).length > 0) {
            projected[key] = projectedValue;
          }
        } else {
          projected[key] = source[key];
        }
      } 
    return projected;
  }

  const projectedObject = project(src, proto);
  console.log(projectedObject);

  document.write('<h2>'+'Q1.3  Projected object res : '+ '</h2>');
  document.write(JSON.stringify(projectedObject));

